import 'package:flutter/material.dart';
import 'package:hrm_demo/features/splash/view/splash_view.dart';
import 'package:hrm_demo/firebase_service.dart';
import 'package:hrm_demo/utils/navigation_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashView(),
      navigatorKey: NavigationService.instance.navigatorKey,
      debugShowCheckedModeBanner: false,
    );
  }
}

