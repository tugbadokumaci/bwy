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
const String welcomeRoute = '/welcome';
const String loginRoute = '/logIn';
const String signupRoute = '/signUp';
const String bwyRoute = '/bwy';
const String servicesRoute = '/services';
const String profileRoute = '/profile';

class ApiConstants {
  ApiConstants._();
  static const String BASE_URL = "https://www.codeocean.net";
}
