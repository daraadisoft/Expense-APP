import 'package:expense_app/features/login/view/login_view.dart';
import 'package:expense_app/firebase_service.dart';
import 'package:expense_app/utils/base_controller.dart';
import 'package:expense_app/utils/navigation_service.dart';

class HomeController extends BaseController{


  void logout()async{
    await FirebaseService.auth.signOut();
    NavigationService.instance.pushAndRemoveUntil(const LoginView());
  }

}