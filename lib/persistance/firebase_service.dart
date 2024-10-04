// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:tedbook/utils/utils.dart';
//
// class FirebaseService{
//  setPresentationOptions() async {
//    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//        alert: true, badge: true, sound: true);
//    try {
//      var token = await FirebaseMessaging.instance.getToken();
//      debugLog("FCM token => $token");
//    } catch (e) {
//      debugLog("Error getting FCM token: $e");
//    }
//  }
//   FirebaseMessaging.instance.requestPermission();
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//   alert: true,
//   badge: true,
//   sound: true,
//   );
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   FirebaseMessaging.instance.onTokenRefresh.listen((event) async {
//   debugLog("onTokenRefresh");
//   UserData userData = getInstance();
//   if ((await userData.accessToken())?.isNotEmpty == true) {
//   ApiProvider apiProvider = getInstance();
//   apiProvider.setFCMToken(event).then((value) async {
//   debugLog("onTokenRefresheddddd");
//   userData.setNeedRefreshFCMToken(false);
//   }).catchError((e) {
//   userData.setFCMToken(event);
//   });
//   }
//   });
// }