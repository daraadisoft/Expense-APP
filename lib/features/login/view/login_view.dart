import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/features/login/controller/login_controller.dart';
import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:expense_app/utils/app_theme.dart';
import 'package:expense_app/utils/app_translate_key.dart';
import 'package:expense_app/utils/custom_decoration.dart';
import 'package:expense_app/utils/validate_form.dart';
import 'package:expense_app/utils/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return loginController;
      },
      child: Consumer<LoginController>(
        builder: (context, controller, child) {
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
                                  AppTranslateKey.login.tr(),
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
                                      labelText: AppTranslateKey.email.tr()),
                                ),
                                const SizedBox(
                                  height: AppSize.defaultPadding,
                                ),
                                TextFormField(
                                  controller: controller.emailController,
                                  validator: (v) {
                                    return ValidateForm.validationPassword(v);
                                  },
                                  decoration: InputDecoration(
                                      labelText: AppTranslateKey.password.tr()),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      AppTranslateKey.forgetPassword.tr(),
                                      style: AppTheme.getTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          decoration: TextDecoration.underline,
                                          color: AppColor.primaryColor),
                                    ),
                                  ),
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
                                            onPressed: () {
                                              if (controller
                                                  .keyForm.currentState!
                                                  .validate()) {}
                                            },
                                            child: Text(
                                                AppTranslateKey.login.tr())),
                                      ),
                                      const SizedBox(
                                        width: AppSize.defaultPadding,
                                      ),
                                      Expanded(
                                        child: CustomButton(
                                            backgroundColor: AppColor.grey,
                                            onPressed: () {},
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
