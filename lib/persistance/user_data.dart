import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedbook/model/response/general_user_data_response.dart';
import 'package:tedbook/utils/utils.dart';

class UserData {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  UserData._();

  // Attention!!
  // Don't use create or default constructor. Use getInstance() method to get UserData object
  factory UserData.create() => UserData._();

  Future<void> setLang(String lang) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('lang', lang);
  }

  Future<String> getLang() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('lang') ?? "ru";
  }

  Future<void> saveGeneralToken(
    String accessToken,
    String refreshToken,
  ) async {
    debugLog("accessToken: $accessToken");
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('general_access_token', accessToken);
    await prefs.setString('general_refresh_token', refreshToken);
  }

  Future<void> saveAccessToken(String accessToken) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('general_access_token', accessToken);
  }

  Future<void> saveRefreshToken(String accessToken) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('general_refresh_token', accessToken);
  }

  Future<String?> accessToken() async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    return prefs.getString('general_access_token');
  }

  Future<String?> accessTokenExpirationDate() async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    return prefs.getString('access_token_expiration_date');
  }

  Future<String?> refreshToken() async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    return prefs.getString('general_refresh_token');
  }

  Future<void> saveGeneralUserData(GeneralUserData data) async {
    final SharedPreferences prefs = await _prefs;
    if (data.id != null) prefs.setInt('id', data.id!);
    prefs.setString('nickName', data.nickName ?? "");
    prefs.setString('phone', data.phone ?? "");
    prefs.setString('fio', data.fio ?? "");
    prefs.setString('pinfl', data.pinfl ?? "");
    prefs.setInt('genderCode', data.genderCode ?? 0);
    prefs.setString('genderName', data.genderName ?? "");
    prefs.setString('lang', data.lang ?? "uz");
    prefs.setStringList('roles',
        data.roles?.map((role) => json.encode(role.toJson())).toList() ?? []);
  }

  Future<String?> userId() async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    return prefs.getString('id');
  }

  Future<String?> pinfl() async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    return prefs.getString('pinfl');
  }

  Future<void> clearAllData() async {
    final SharedPreferences prefs = await _prefs;
    final a = prefs.getKeys().toList();
    for (int i = 0; i < a.length; i++) {
      await prefs.remove(a[i]);
    }
  }
}
