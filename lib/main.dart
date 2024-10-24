import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/utils/app_theme.dart';
import 'package:expense_app/utils/navigation_service.dart';
import 'package:expense_app/utils/translation.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'features/splash/view/splash_view.dart';
import 'firebase_service.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initFirebase();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: Translation.listLanguageSupport,
      path: Translation.pathTranslate,
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.appLightTheme,
      home: const SplashView(),
      navigatorKey: NavigationService.instance.navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

