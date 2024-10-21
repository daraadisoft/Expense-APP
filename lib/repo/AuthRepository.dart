import 'package:firebase_auth/firebase_auth.dart';
import 'package:hrm_demo/firebase_service.dart';

class AuthRepository{

  AuthRepository._privateConstructor();

  static final AuthRepository instance = AuthRepository._privateConstructor();

  factory AuthRepository() {
    return instance;
  }

  Future<User?> checkCurrentUser()async{
    try{
      var data = FirebaseService.auth.currentUser;
      return data;
    }catch(e){
      print('Error : ${e.toString()}');
      return null;
    }
  }
}