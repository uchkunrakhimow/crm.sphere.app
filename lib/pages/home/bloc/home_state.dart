part of 'home_bloc.dart';

@immutable
class HomeState {
  final BaseStatus loginStatus;

  HomeState({required this.loginStatus});

  factory HomeState.initial() {
    return HomeState(loginStatus: BaseStatus.initial());
  }

  HomeState copyWith({BaseStatus? loginStatus}) {
    return HomeState(loginStatus: loginStatus ?? this.loginStatus);
  }
}
