import 'package:bwy/utils/constants.dart';
import 'package:bwy/utils/generator.dart';
import '../models/user_model.dart';
import '../service_locator.dart';
import '../utils/resource.dart';

mixin MixinUserFeature {
  RestClient client = locator<RestClient>();

  Future<Resource<List<UserModel>>> getData() async {
    try {
      final restClient = RestClient.create();
      List<UserModel> value = await restClient.getData();
      return Resource.success(value);
    } catch (e) {
      return Resource.error('Failed to fetch datas: $e');
    }
  }

  Future<Resource<UserModel>> login(String email, String password) async {
    final restClient = RestClient.create();
    Resource<UserModel> value = await restClient.login({"userEmail": email, "userPassword": password});
    if (value.status == Status.SUCCESS) {
      Constants.USER = value.data!;
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!);
    }
  }
  // Future<Resource<List<UserModel>>> fetchData() async {
  //   try {
  //     final restClient = RestClient.create();
  //     List<UserModel> value = await restClient.fetchData();
  //     return Resource.success(value);
  //   } catch (e) {
  //     return Resource.error('Failed to fetch datas: $e');
  //   }
  // }
}
