part of 'home_bloc.dart';

@immutable
class HomeState {
  final BaseStatus status;
  final int? selectedType;
  final List<OrderModel>? orders;
  final List<OrderModel>? archives;
  final String? sentOrderId;

  HomeState({
    required this.status,
    this.selectedType,
    this.orders,
    this.archives,
    this.sentOrderId,
  });

  factory HomeState.initial() {
    return HomeState(status: BaseStatus.initial());
  }

  HomeState copyWith({
    BaseStatus? status,
    int? selectedType,
    List<OrderModel>? orders,
    List<OrderModel>? archives,
    String? sentOrderId,
  }) {
    return HomeState(
      status: status ?? this.status,
      selectedType: selectedType ?? this.selectedType,
      orders: orders ?? this.orders,
      archives: archives ?? this.archives,
      sentOrderId: sentOrderId ?? this.sentOrderId,
    );
  }
}
