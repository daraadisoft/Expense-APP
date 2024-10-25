import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:expense_app/utils/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:url_strategy/url_strategy.dart';

class FirebaseService {
  static late FirebaseAuth auth;

  static Future<void> initFirebase() async {
    await Firebase.initializeApp(options: _getFirebaseOption());
    auth = FirebaseAuth.instance;
    await FirebaseMessaging.instance.requestPermission();
    initNotificationChannel();
    listenToNotification();
  }

  static void listenToNotification() async {
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      if (remoteMessage.notification == null) {
        return;
      }

      var data = {
        'title': remoteMessage.notification!.title,
        'body': remoteMessage.notification!.body
      };
      alertNotification(data: data);
    });
  }

  static void initNotificationChannel() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelGroupKey: BaseNotificationEnum.channelGroupKey,
              channelKey: BaseNotificationEnum.channelGroupKey,
              channelName: BaseNotificationEnum.channelGroupKey,
              channelDescription: BaseNotificationEnum.channelGroupKey,
              defaultColor: AppColor.primaryColor,
              ledColor: AppColor.white)
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: BaseNotificationEnum.channelGroupKey,
              channelGroupName: BaseNotificationEnum.channelGroupKey)
        ],
        debug: true);
  }

  static void alertNotification({required Map data}) async {
    print("HAHA123 : ${data}");
    try {
      await AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: DateTime.now().second,
        channelKey: BaseNotificationEnum.channelGroupKey,
        title: data['title'],
        body: data['body'],
      ));
    } catch (e) {
      print('ERROR ${e.toString()}');
    }
  }

  static FirebaseOptions _getFirebaseOption() {
    if (kIsWeb) {
      setPathUrlStrategy();
      return const FirebaseOptions(
          apiKey: 'AIzaSyDBMGhEYg6pTdkCDuRXZwzbIAPdwiaHr9c',
          appId: '1:368350921654:web:dd5c3dfe58f85345f67717',
          messagingSenderId: '368350921654',
          projectId: 'fir-firebase-737ba');
    }

    return const FirebaseOptions(
        apiKey: 'AIzaSyCxF6wu4zUkM4xvgjJjZYLWQ9-Llvz55cA',
        appId: '1:368350921654:android:39a66ac33ebc3a94f67717',
        messagingSenderId: '368350921654',
        projectId: 'fir-firebase-737ba');
  }
}

class BaseNotificationEnum {
  static const String channelGroupKey = 'my_expense_app';
}
