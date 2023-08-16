import 'package:bwy/utils/generator.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'bloc/home_page/home_repository.dart';
import 'bloc/login_page/login_repository.dart';
import 'bloc/services_page/services_repository.dart';
import 'bloc/signup_page/signup_repository.dart';
import 'bloc/welcome_page/welcome_repository.dart';

GetIt locator = GetIt.instance;

class DependencyInjection {
  DependencyInjection() {
    provideRepositories();
  }

  void provideRepositories() {
    locator.registerSingleton<Dio>(Dio());
    locator.registerSingleton<RestClient>(RestClient(locator<Dio>()));
    locator.registerFactory<WelcomeRepository>(() => WelcomeRepository());
    locator.registerFactory<HomeRepository>(() => HomeRepository(locator<RestClient>()));
    locator.registerFactory<LoginRepository>(() => LoginRepository(locator<RestClient>()));
    locator.registerFactory<SignupRepository>(() => SignupRepository(locator<RestClient>()));
    locator.registerFactory<ServicesRepository>(() => ServicesRepository());
  }
}
