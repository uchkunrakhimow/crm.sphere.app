part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class InitEvent extends HomeEvent {}

class RefreshEvent extends HomeEvent {}

class ChangeTypeEvent extends HomeEvent {
  final int selectedTypeIndex;

  ChangeTypeEvent({required this.selectedTypeIndex});
}

class SendCommentEvent extends HomeEvent {
  final String orderId;

  SendCommentEvent({required this.orderId});
}

class PutOrderEvent extends HomeEvent {
  final String orderId;
  final String status;

  PutOrderEvent({required this.orderId, required this.status});
}

class LogoutEvent extends HomeEvent {}
