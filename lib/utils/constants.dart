import '../models/user_model.dart';

class Constants {
  Constants._();

  static UserModel USER = UserModel(
    userId: 0,
    userName: '',
    userSurname: '',
    userBalance: 0,
    userEmail: '',
    userPassword: '',
  );
}

const String homeRoute = '/home';

class ApiConstants {
  ApiConstants._();
  static const String BASE_URL = "https://www.codeocean.net";
}
