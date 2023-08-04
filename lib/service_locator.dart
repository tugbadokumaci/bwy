import 'package:bwy/utils/generator.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'bloc/home_page/home_repository.dart';

GetIt locator = GetIt.instance;

class DependencyInjection {
  DependencyInjection() {
    provideRepositories();
  }

  void provideRepositories() {
    locator.registerSingleton<Dio>(Dio());
    locator.registerSingleton<RestClient>(RestClient(locator<Dio>()));
    locator.registerFactory<HomeRepository>(() => HomeRepository(locator<RestClient>()));
  }
}
