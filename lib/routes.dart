// ignore_for_file: non_constant_identifier_names

import 'package:bwy/service_locator.dart';
import 'package:bwy/utils/constants.dart';
import 'package:flutter/material.dart';

import 'bloc/home_page/home_cubit.dart';
import 'bloc/home_page/home_repository.dart';
import 'bloc/home_page/home_view.dart';

class RouteGenerator {
  static Route<dynamic> GenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => HomeView(viewModel: HomeCubit(repo: locator.get<HomeRepository>())));
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
