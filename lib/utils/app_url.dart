class AppUrl{

  static const String baseURL = 'https://us-central1-fir-firebase-737ba.cloudfunctions.net';




  //category
  static const String getCategory = '$baseURL/getCategoriesApi';



  //auth
  static const String registerURL = '$baseURL/createUserApi';
  static const String requestVerifyAccount = '$baseURL/requestVerifyAccountApi';
}