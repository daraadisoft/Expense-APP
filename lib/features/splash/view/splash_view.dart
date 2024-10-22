import 'package:expense_app/features/splash/controller/splash_controller.dart';
import 'package:expense_app/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  SplashController splashController = SplashController();

  @override
  Widget build(BuildContext context) {
   return ChangeNotifierProvider(
    create: (context){
      splashController.init();
      return splashController;
    },
     child: Consumer<SplashController>(
       builder: (context,controller,child){
         return Scaffold(
           body: Center(
             child: Container(
                 constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
                 child: Lottie.asset(AppAssets.splashLottie)),
           ),
         );
       },
     ),
   );

  }
}
