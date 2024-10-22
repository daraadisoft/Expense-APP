import 'package:expense_app/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

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