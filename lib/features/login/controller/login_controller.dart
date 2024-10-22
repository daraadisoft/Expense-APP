import 'package:expense_app/utils/base_controller.dart';
import 'package:flutter/cupertino.dart';

class LoginController extends BaseController{

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isHidePassword = true;


  final keyForm = GlobalKey<FormState>();

  bool isLoading = false;

}