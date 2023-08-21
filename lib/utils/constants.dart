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
const String contactRoute = '/contact';
const String profileRoute = '/profile';

class ApiConstants {
  ApiConstants._();
  static const String BASE_URL = "https://www.codeocean.net";
}

const String phoneNumber = '+902244083848';
const String officeAddress = 'Beşevler Konak Mh Burgaz Sk. No:2-A D: 2, Yıldız Plaza Nilüfer / BURSA';
const String emailAddress = 'info@bursawebyazilim.com';
