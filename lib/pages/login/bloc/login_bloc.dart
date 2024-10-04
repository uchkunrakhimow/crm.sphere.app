import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tedbook/model/request/login_request.dart';
import 'package:tedbook/persistance/base_status.dart';
import 'package:tedbook/persistance/remote/api_provider.dart';
import 'package:tedbook/persistance/service_locator.dart';
import 'package:tedbook/persistance/user_data.dart';
import 'package:tedbook/utils/utils.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<LoginCheckEvent>(login);
  }

  login(LoginCheckEvent event, Emitter<LoginState> emit) async {
    if (_usernameCtrl.text.isEmpty) {
      emit(state.copyWith(
          loginStatus: BaseStatus.errorWithString(
              message: "username bo'sh bo'lishi mumkin emas")));
    } else if (_passwordCtrl.text.isEmpty) {
      emit(state.copyWith(
          loginStatus: BaseStatus.errorWithString(
              message: "password bo'sh bo'lishi mumkin emas")));
    } else {
      LoginRequest request = LoginRequest(
          username: _usernameCtrl.text, password: _passwordCtrl.text);
      emit(state.copyWith(loginStatus: BaseStatus.loading()));
      await _apiProvider.login(request).then(
        (value) async {
          if (value.tokens != null) {
            await _userData.saveGeneralToken(value.tokens!);
            await _userData.saveGeneralUserData(value.user!);
            emit(state.copyWith(loginStatus: BaseStatus.success()));
          } else {
            debugLog("catchError: $value");

          }
        },
      ).catchError((e) {
        emit(state.copyWith(
            loginStatus: BaseStatus.errorWithString(message: e.message)));
      });
    }
  }

  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  TextEditingController get loginCtrl => _usernameCtrl;

  TextEditingController get passwordCtrl => _passwordCtrl;
  final ApiProvider _apiProvider = getInstance();
  final UserData _userData = getInstance();
}
