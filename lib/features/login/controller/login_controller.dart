import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/features/home/view/home_view.dart';
import 'package:expense_app/repo/auth_repository.dart';
import 'package:expense_app/utils/app_translate_key.dart';
import 'package:expense_app/utils/base_controller.dart';
import 'package:expense_app/utils/navigation_service.dart';
import 'package:expense_app/utils/widget/pop_up_dialog.dart';
import 'package:flutter/cupertino.dart';

class LoginController extends BaseController {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isHidePassword = true;

  final keyForm = GlobalKey<FormState>();

  bool isLoading = false;

  void clickShowPassword({required bool data}) {
    isHidePassword = data;
    notifyListeners();
  }

  void login() async {
    isLoading = true;
    notifyListeners();

    var data = await AuthRepository.instance.loginUser(email: emailController.text, password: passwordController.text);

    //error password or email
    if(data.data == null){
      PopUpDialog.showErrorDialog(message: data.message);
      isLoading = false;
      notifyListeners();
      return;
    }

    //need verify account
    if(!data.data!.user!.emailVerified){
      PopUpDialog.showErrorDialog(message: AppTranslateKey.pleaseVerifyYourEmail.tr(),onClick: (){
        NavigationService.instance.pop();
        requestVerifyAccount(email: emailController.text);
      });
      isLoading = false;
      notifyListeners();
      return;
    }

    NavigationService.instance.pushAndRemoveUntil(const HomeView());
    isLoading = false;
    notifyListeners();
  }


  void requestVerifyAccount({required String email})async{
    PopUpDialog.showLoadingDialog();


    var data = await AuthRepository.instance.requestVerifyAccount(email: email);

    NavigationService.instance.pop();

    //error api
    if(!data.success){
      PopUpDialog.showErrorDialog(message: data.message);
      return;
    }

    PopUpDialog.showSnackBarMessage(message: data.message);

  }
}
