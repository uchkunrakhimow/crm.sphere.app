import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tedbook/persistance/base_status.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {}

  final _loginCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  TextEditingController get loginCtrl => _loginCtrl;

  TextEditingController get passwordCtrl => _passwordCtrl;
// final ApiProvider _apiProvider = getInstance();
// final UserData _userData = getInstance();
}
