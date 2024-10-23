import 'package:expense_app/features/login/view/login_view.dart';
import 'package:expense_app/features/register/model/register_model.dart';
import 'package:expense_app/repo/auth_repository.dart';
import 'package:expense_app/utils/base_controller.dart';
import 'package:expense_app/utils/navigation_service.dart';
import 'package:expense_app/utils/widget/pop_up_dialog.dart';
import 'package:flutter/cupertino.dart';

class RegisterController extends BaseController{


  bool isHidePassword = true;

  bool isHideCfPassword = true;

  final keyForm = GlobalKey<FormState>();

  bool isLoading = false;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController cfPasswordController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();

  void clickShowPassword({required bool data}){
    isHidePassword = data;
    notifyListeners();
  }

  void clickShowCFPassword({required bool data}){
    isHideCfPassword = data;
    notifyListeners();
  }

  void register()async{

    isLoading = true;
    notifyListeners();

    var data = await AuthRepository.instance.registerAccount(registerModel: RegisterModel(email: emailController.text, password: passwordController.text, displayName: fullNameController.text));

    isLoading = false;
    notifyListeners();

    //success
    if(data.success){
      NavigationService.instance.pushAndRemoveUntil(const LoginView());
      return;
    }

    //error
    PopUpDialog.showErrorDialog(message: data.message);


  }



}
