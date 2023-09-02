import 'package:bwy/inheritance/mixin_user_feature.dart';

import '../../models/user_model.dart';
import '../../utils/generator.dart';
import '../../utils/resource.dart';

class SignupRepository with MixinUserFeature {
  RestClient client;
  SignupRepository(this.client);
  Future<Resource<UserModel>> register(String userName, String userSurname, int userBalance, String userPhone,
      String userEmail, String userPassword) async {
    final restClient = RestClient.create();
    var value = await restClient.signup({
      "userName": userName,
      "userSurname": userSurname,
      "userBalance": userBalance,
      "userPhone": userPhone,
      "userEmail": userEmail,
      "userPassword": userPassword,
    });
    if (value.status == Status.SUCCESS) {
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!, value.statusCode);
    }
  }
}
