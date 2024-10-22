import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/features/login/view/login_view.dart';
import 'package:expense_app/features/register/controller/register_controller.dart';
import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:expense_app/utils/app_theme.dart';
import 'package:expense_app/utils/app_translate_key.dart';
import 'package:expense_app/utils/custom_decoration.dart';
import 'package:expense_app/utils/navigation_service.dart';
import 'package:expense_app/utils/validate_form.dart';
import 'package:expense_app/utils/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  RegisterController registerController = RegisterController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context){
      return registerController;
    },
      child: Consumer<RegisterController>(
        builder: (context,controller,child){
          return Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSize.defaultPadding),
                    child: Form(
                      key: controller.keyForm,
                      child: Stack(
                        children: [
                          Container(
                            padding:
                            const EdgeInsets.all(AppSize.defaultPadding),
                            constraints: const BoxConstraints(
                              maxWidth: AppSize.widthOfFormAuth,
                            ),
                            decoration:
                            CustomDecoration.customBoxDecorationAuth(
                                context: context),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: AppSize.defaultPadding * 2,
                                ),
                                Text(
                                  AppTranslateKey.register.tr(),
                                  style: AppTheme.getTextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: AppSize.defaultPadding,
                                ),
                                TextFormField(
                                  controller: controller.emailController,
                                  validator: (v) {
                                    return ValidateForm.validationEmail(v);
                                  },
                                  decoration: InputDecoration(
                                      labelText: AppTranslateKey.email.tr(),
                                      prefixIcon:
                                      const Icon(Icons.email_outlined)),
                                ),
                                const SizedBox(
                                  height: AppSize.defaultPadding,
                                ),
                                TextFormField(
                                  controller: controller.fullNameController,
                                  validator: (v) {
                                    return ValidateForm.validationFullName(v);
                                  },
                                  decoration: InputDecoration(
                                      labelText: AppTranslateKey.fullName.tr(),
                                      prefixIcon:
                                      const Icon(Icons.person_2_outlined)),
                                ),
                                const SizedBox(
                                  height: AppSize.defaultPadding,
                                ),
                                TextFormField(
                                  controller: controller.passwordController,
                                  validator: (v) {
                                    return ValidateForm.validationPassword(v);
                                  },
                                  obscureText: controller.isHidePassword,
                                  decoration: InputDecoration(
                                      labelText: AppTranslateKey.password.tr(),
                                      prefixIcon:
                                      const Icon(Icons.password_outlined),
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            controller.clickShowPassword(data: !controller.isHidePassword);
                                          },
                                          child: Icon(controller.isHidePassword
                                              ? Icons.dangerous_outlined
                                              : Icons
                                              .remove_red_eye_outlined))),
                                ),
                                const SizedBox(
                                  height: AppSize.defaultPadding,
                                ),
                                TextFormField(
                                  controller: controller.cfPasswordController,
                                  validator: (v) {
                                    return ValidateForm.validationCFPassword(v,password: controller.passwordController.text);
                                  },
                                  obscureText: controller.isHideCfPassword,
                                  decoration: InputDecoration(
                                      labelText: AppTranslateKey.password.tr(),
                                      prefixIcon:
                                      const Icon(Icons.password_outlined),
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            controller.clickShowCFPassword(data: !controller.isHideCfPassword);
                                          },
                                          child: Icon(controller.isHideCfPassword
                                              ? Icons.dangerous_outlined
                                              : Icons
                                              .remove_red_eye_outlined))),
                                ),
                                const SizedBox(
                                  height: AppSize.defaultPadding,
                                ),
                                Visibility(
                                  visible: !controller.isLoading,
                                  replacement: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomButton(
                                            backgroundColor: AppColor.grey,
                                            onPressed: () {
                                              NavigationService.instance.pushAndRemoveUntil(const LoginView());
                                            },
                                            child: Text(
                                                AppTranslateKey.back.tr())),
                                      ),
                                      const SizedBox(
                                        width: AppSize.defaultPadding,
                                      ),
                                      Expanded(
                                        child: CustomButton(
                                            backgroundColor: AppColor.primaryColor,
                                            onPressed: () {

                                              if(controller.keyForm.currentState!.validate()){
                                                controller.register();
                                              }

                                            },
                                            child: Text(
                                                AppTranslateKey.register.tr())),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: AppSize.defaultPadding * 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
