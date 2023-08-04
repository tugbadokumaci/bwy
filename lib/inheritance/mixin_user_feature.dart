import 'package:bwy/utils/generator.dart';

import '../models/user_model.dart';
import '../service_locator.dart';
import '../utils/resource.dart';

mixin MixinUserFeature {
  RestClient client = locator<RestClient>();

  // Future<Resource<List<UserModel>>> getData() async {
  //   try {
  //     debugPrint('bunu gör');
  //     final restClient = RestClient.create();
  //     List<UserModel> value = await restClient.getData();
  //     debugPrint('bunu göremiyorum');
  //     return Resource.success(value);
  //   } catch (e) {
  //     debugPrint('get data CATCH CATCHED !!!!');
  //     return Resource.error('Failed to fetch datas: $e');
  //   }
  // }
  Future<Resource<List<UserModel>>> fetchData() async {
    try {
      final restClient = RestClient.create();
      List<UserModel> value = await restClient.fetchData();
      return Resource.success(value);
    } catch (e) {
      return Resource.error('Failed to fetch datas: $e');
    }
  }
  // Future<Resource<UserModel>> createUser(
  //     String userName, String userSurname, int userBalance, String userEmail, String userPassword) async {
  //   try {
  //     final restClient = RestClient.create();
  //     var value = await restClient.createUser({
  //       "userName": userName,
  //       "userSurname": userSurname,
  //       "userBalance": userBalance,
  //       "userEmail": userEmail,
  //       "userPassword": userPassword,
  //     });
  //     debugPrint(value.toString());
  //     return Resource.success(value);
  //   } catch (e) {
  //     return Resource.error('Failed to create user: $e');
  //   }
  // }
}
