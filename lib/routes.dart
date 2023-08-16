// ignore_for_file: non_constant_identifier_names

import 'package:bwy/bloc/bwy_page/bwy_view.dart';
import 'package:bwy/bloc/login_page/login_cubit.dart';
import 'package:bwy/bloc/login_page/login_repository.dart';
import 'package:bwy/bloc/welcome_page/welcome_repository.dart';
import 'package:bwy/service_locator.dart';
import 'package:bwy/utils/constants.dart';
import 'package:flutter/material.dart';

import 'bloc/home_page/home_cubit.dart';
import 'bloc/home_page/home_repository.dart';
import 'bloc/home_page/home_view.dart';
import 'bloc/login_page/login_view.dart';
import 'bloc/services_page/services_cubit.dart';
import 'bloc/services_page/services_repository.dart';
import 'bloc/services_page/services_view.dart';
import 'bloc/signup_page/signup_cubit.dart';
import 'bloc/signup_page/signup_repository.dart';
import 'bloc/signup_page/signup_view.dart';
import 'bloc/welcome_page/welcome_cubit.dart';
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
      case servicesRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ServicesView(viewModel: ServicesCubit(repo: locator.get<ServicesRepository>())));

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
