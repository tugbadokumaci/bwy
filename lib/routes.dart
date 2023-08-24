// ignore_for_file: non_constant_identifier_names

import 'package:bwy/service_locator.dart';
import 'package:bwy/constants/constants.dart';
import 'package:flutter/material.dart';

import 'bloc/bwy_page/bwy_view.dart';
import 'bloc/contact_page/contact_view.dart';
import 'bloc/home_page/home_cubit.dart';
import 'bloc/home_page/home_repository.dart';
import 'bloc/home_page/home_view.dart';
import 'bloc/login_page/login_cubit.dart';
import 'bloc/login_page/login_repository.dart';
import 'bloc/login_page/login_view.dart';
import 'bloc/profile_page/profile_cubit.dart';
import 'bloc/profile_page/profile_repository.dart';
import 'bloc/profile_page/profile_view.dart';
import 'bloc/signup_page/signup_cubit.dart';
import 'bloc/signup_page/signup_repository.dart';
import 'bloc/signup_page/signup_view.dart';
import 'bloc/welcome_page/welcome_cubit.dart';
import 'bloc/welcome_page/welcome_repository.dart';
import 'bloc/welcome_page/welcome_view.dart';

class RouteGenerator {
  static Route<dynamic> GenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => HomeView(viewModel: HomeCubit(repo: locator.get<HomeRepository>())));
      case welcomeRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return WelcomeView(viewModel: WelcomeCubit(repo: locator.get<WelcomeRepository>()));
          },
        );
      case loginRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => LoginView(viewModel: LoginCubit(repo: locator.get<LoginRepository>())));
      case signupRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => SignupView(viewModel: SignupCubit(repo: locator.get<SignupRepository>())));
      case bwyRoute:
        return MaterialPageRoute(settings: settings, builder: (_) => BwyView());
      case contactRoute:
        return MaterialPageRoute(settings: settings, builder: (_) => ContactView());
      case profileRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ProfileView(viewModel: ProfileCubit(repo: locator.get<ProfileRepository>())));

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
