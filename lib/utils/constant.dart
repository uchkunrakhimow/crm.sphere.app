import 'package:flutter/services.dart';

class Constant {
  ///sudo nano ~/.zshrc
  ///flutter build apk --split-per-abi
  /// flutter pub run flutter_launcher_icons:main
  /// flutter run -d windows --no-sound-null-safety
  /// flutter build apk --release --no-sound-null-safety
  /// flutter build apk --split-per-abi --no-sound-null-safety
  /// flutter build appbundle --release --no-sound-null-safety
  /// flutter pub run build_runner watch --delete-conflicting-outputs
  /// flutter packages pub run build_runner build --delete-conflicting-outputs
  static const String cardBoxName = "credit_card_box";

  static const androidChannel = MethodChannel('androidNativeChannel');
  static const iOSChannel = MethodChannel('iosNativeChannel');
}

const String URL = 'https://';
const String SERVER_ERROR = 'Произошла ошибка сервера';
