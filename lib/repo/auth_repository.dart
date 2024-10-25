import 'package:expense_app/features/register/model/register_model.dart';
import 'package:expense_app/firebase_service.dart';
import 'package:expense_app/utils/app_url.dart';
import 'package:expense_app/utils/data/category_enum.dart';
import 'package:expense_app/utils/data/data_state.dart';
import 'package:expense_app/utils/http_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthRepository {
  AuthRepository._privateConstructor();

  static final AuthRepository instance = AuthRepository._privateConstructor();

  factory AuthRepository() {
    return instance;
  }

  Future<User?> checkCurrentUser() async {
    try {
      var data = FirebaseService.auth.currentUser;
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<DataState<UserCredential>> loginUser(
      {required String email, required String password}) async {
    try {
      var auth = await FirebaseService.auth
          .signInWithEmailAndPassword(email: email, password: password);
      return DataState(
        data: auth,
      );
    } on FirebaseAuthException catch (e) {
      return DataState(message: e.code, data: null);
    }
  }

  Future<DataState<String>> requestVerifyAccount(
      {required String email}) async {
    try {
      var response = await HttpService.httpService
          .post(url: AppUrl.requestVerifyAccount, body: {'email': email});
      return DataState(
          data: response.data['data'],
          success: response.data['success'],
          message: response.data['message']);
    } catch (e) {
      return DataState(data: null, message: e.toString(), success: false);
    }
  }

  Future<DataState<bool>> registerAccount(
      {required RegisterModel registerModel}) async {
    try {
      var response = await HttpService.httpService
          .post(url: AppUrl.registerURL, body: registerModel.toJson());

      return DataState(
          data: response.data['data'] != null,
          success: response.data['success'] ?? false,
          message: response.data['message'].toString());
    } catch (e) {
      return DataState(data: false, success: false, message: e.toString());
    }
  }

  Future<DataState<bool>> logOut()async{
    try{
      await FirebaseService.auth.signOut();
      FirebaseMessaging.instance.unsubscribeFromTopic(CategoryEnum.topicNotification);
      return DataState(
          success: true,
         data: true,
      );
    }catch(e){
      return DataState(
        success: false,
        data: false,
        message: e.toString()
      );
    }
  }

}
