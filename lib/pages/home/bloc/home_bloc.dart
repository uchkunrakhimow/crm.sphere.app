import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tedbook/model/request/put_order_request.dart';
import 'package:tedbook/model/response/order_response.dart';
import 'package:tedbook/persistance/base_status.dart';
import 'package:tedbook/persistance/remote/api_provider.dart';
import 'package:tedbook/persistance/service_locator.dart';
import 'package:tedbook/persistance/user_data.dart';
import 'package:tedbook/utils/utils.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<InitEvent>((event, emit) {
      emit(state.copyWith(selectedType: 0));
      socketInit();
      getOrders();
    });
    on<RefreshEvent>((_, __) => getOrders());
    on<SendCommentEvent>(sendComment);
    on<OrderCompletionEvent>(orderCompletion);
    on<ChangeTypeEvent>((event, emit) =>
        emit(state.copyWith(selectedType: event.selectedTypeIndex)));
    on<LogoutEvent>(logout);
  }

  socketInit() async {
    // Connect to the socket server
    socket = IO.io(
      ApiProvider.baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket']) // use web socket transport
          .setPath('/ws') // Ensure this matches your server configuration
          .enableAutoConnect() // Auto-connect when the service is initialized
          .build(),
    );

    // Listen for new comments
    socket.on('newComment', (newComment) {
      MessageModel newMessage = MessageModel.fromJson(newComment);
      List<OrderModel> list = [];
      for (var element in _ordersList) {
        if (element.id == newMessage.orderId) {
          element.messages?.add(MessageModel.fromJson(newComment));
        }
        list.add(element);
      }
      // _ordersList.first.messages?.add(newMessage);
      debugLog("socket.on ${_ordersList.first.messages?.length}");
      emit(state.copyWith(
        status: BaseStatus.sent(),
        orders: _ordersList,
        sentOrderId: newMessage.orderId,
      ));

      // Handle new comment
      debugLog('New comment: $newComment');
    });
  }

  getOrders() async {
    emit(state.copyWith(status: BaseStatus.loading()));
    await _apiProvider.getOrders(await _userData.userId() ?? "").then(
      (value) {
        if (value.ordersList?.isNotEmpty == true) {
          _ordersList.clear();
          _archivesList.clear();
          for (var item in value.ordersList!) {
            commentControllers[item.id ?? ""] = TextEditingController();
            commentFocuses[item.id ?? ""] = FocusNode();
            if (item.isArchive ?? false) {
              _archivesList.add(item);
            } else {
              _ordersList.add(item);
            }
          }
          emit(state.copyWith(
            status: BaseStatus.success(),
            orders: _ordersList,
            archives: _archivesList,
          ));
        }
      },
    ).onError((err, __) {
      emit(
        state.copyWith(
            status: BaseStatus.errorWithString(message: err.toString())),
      );
    });
  }

  orderCompletion(OrderCompletionEvent event, Emitter<HomeState> emit) async {
    PutOrderRequest request =
        PutOrderRequest(isArchive: true, status: event.status);
    await _apiProvider.orderCompletion(orderId: event.orderId, request: request).then(
      (value) {
        emit(state.copyWith(status: BaseStatus.updated()));
        getOrders();
      },
    );
  }

  sendComment(SendCommentEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(status: BaseStatus.sending()));
    // Join the room
    socket.emit('join_room', event.orderId);
    socket.emit('sendMessage', {
      'orderId': event.orderId,
      'commentText': commentControllers[event.orderId]?.text,
      'commenterRole': "courier",
    });
  }

  logout(LogoutEvent event, Emitter<HomeState> emit) async {
    await _userData.clearAllData();
    emit(state.copyWith(status: BaseStatus.paging()));
  }

  final ApiProvider _apiProvider = getInstance();
  final UserData _userData = getInstance();
  late IO.Socket socket;
  List<OrderModel> _ordersList = [];
  List<OrderModel> _archivesList = [];
  var commentControllers = {};
  var commentFocuses = {};
}
