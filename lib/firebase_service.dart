import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:url_strategy/url_strategy.dart';

class FirebaseService{
  static late FirebaseAuth auth;
  static Future<void> initFirebase() async {
    await Firebase.initializeApp(options: _getFirebaseOption());
    auth = FirebaseAuth.instance;
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