import 'dart:async';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/features/login/view/login_view.dart';
import 'package:expense_app/features/splash/view/splash_view.dart';
import 'package:expense_app/firebase_service.dart';
import 'package:expense_app/utils/app_translate_key.dart';
import 'package:expense_app/utils/app_url.dart';
import 'package:expense_app/utils/internet_helper.dart';
import 'package:expense_app/utils/navigation_service.dart';
import 'package:expense_app/utils/widget/pop_up_dialog.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpService {
  static final Dio _dioService = Dio();

  static final HttpService httpService = HttpService._internal();

  factory HttpService() {
    return httpService;
  }

  HttpService._internal() {
    _dioService.options.baseUrl = AppUrl.baseURL;
    _dioService.interceptors.add(PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true));
  }

  Future<Map<String, dynamic>> header() async {
    var auth = FirebaseService.auth.currentUser;

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (auth != null) {
      header['Authorization'] = 'Bearer ${await auth.getIdToken(true)}';
    }

    return header;
  }

  Future<Response> post({
    required String url,
    Map body = const {},
  }) async {
    try {
      var response = await _dioService.post(url, options: Options(headers: await header()),data: body);
      return response;
    } on DioException catch (e) {
      if (!await InternetHelper.isHasInternetConnection()) {
        return await post(url: url, body: body);
      }

      var statusCode = e.response?.statusCode ?? 0;

      if (statusCode >= HttpCode.internalServerError) {
        PopUpDialog.showErrorDialog(
            message: AppTranslateKey.internalServerError.tr(),
            onClick: () {
              NavigationService.instance.pop();
              NavigationService.instance.pushAndRemoveUntil(const SplashView());
            });
        await Future.delayed(const Duration(hours: 60));
      }

      if (statusCode == HttpCode.authError) {
        PopUpDialog.showErrorDialog(
            message: AppTranslateKey.sessionExpire.tr(),
            onClick: () {
              NavigationService.instance.pop();
              NavigationService.instance.pushAndRemoveUntil(const LoginView());
            });
        await Future.delayed(const Duration(hours: 60));
      }

      return e.response!;
    }
  }
}

class HttpCode {
  static const internalServerError = 500;
  static const authError = 401;
  static const success = 200;
}
