import 'package:expense_app/features/home/view/home_view.dart';
import 'package:expense_app/features/login/view/login_view.dart';
import 'package:expense_app/repo/auth_repository.dart';
import 'package:expense_app/utils/base_controller.dart';
import 'package:expense_app/utils/navigation_service.dart';

class SplashController extends BaseController {
  @override
  Future<void> init() async {
    super.init();
    await Future.delayed(const Duration(seconds: 3));
    checkCurrentUser();
  }

  void checkCurrentUser() async {
    var data = await AuthRepository.instance.checkCurrentUser();

    //login
    if (data == null) {
      NavigationService.instance.pushAndRemoveUntil(const LoginView());
      return;
    }

    //need verify account
    if (!data.emailVerified) {
      NavigationService.instance.pushAndRemoveUntil(const LoginView());
      return;
    }
    print('HAHA ${await data.getIdToken(true)}');
    NavigationService.instance.pushAndRemoveUntil(const HomeView());
  }



}
