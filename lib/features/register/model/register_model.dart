class RegisterModel{
  String email;
  String password;
  String displayName;
  RegisterModel({required this.email,required this.password,required this.displayName});
  Map toJson() => {
    'email' : email,
    'password':password,
    'displayName' : displayName
  };
}