import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';

import 'app_translate_key.dart';

class ValidateForm{

  static String? validationFullName(String? v){
    if(v == null || v.isEmpty){
      return AppTranslateKey.pleaseEnterTheFullName.tr();
    }

    return null;
  }

  static String? validationEmail(String? v){

    if(v == null || v.isEmpty){
      return AppTranslateKey.pleaseEnterTheEmail.tr();
    }

    if(!EmailValidator.validate(v)){
      return AppTranslateKey.yourEmailEnterIsNotValid.tr();
    }

    return null;
  }

  static String? validationPassword(String? v){
    if(v == null || v.isEmpty){
      return AppTranslateKey.pleaseEnterThePassword.tr();
    }

    if(v.length < 6){
      return AppTranslateKey.minimumPassword.tr();
    }

    return null;
  }

  static String? validationCFPassword(String? v,{required String password}){
    if(v == null || v.isEmpty){
      return AppTranslateKey.pleaseEnterThePassword.tr();
    }

    if(v.length < 6){
      return AppTranslateKey.minimumPassword.tr();
    }

    if(v != password){
      return AppTranslateKey.confirmPasswordNotMatch.tr();
    }

    return null;
  }


}