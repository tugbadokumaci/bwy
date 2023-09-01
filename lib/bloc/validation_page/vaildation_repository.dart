import 'package:bwy/inheritance/mixin_user_feature.dart';

import '../../utils/generator.dart';
import '../../utils/resource.dart';

class ValidationRepository with MixinUserFeature {
  RestClient client;
  ValidationRepository(this.client);

  Future<Resource<bool>> sendOtp(String mailTo) async {
    final restClient = RestClient.create();
    Resource<bool> value = await restClient.sendOtp({"emailTo": mailTo});
    if (value.status == Status.SUCCESS) {
      return Resource.success(true);
    } else {
      return Resource.error(value.errorMessage!, value.statusCode);
    }
  }

  Future<Resource<bool>> validateOtp(String mailTo, String otpPassword) async {
    final restClient = RestClient.create();
    Resource<bool> value = await restClient.validateOtp({"emailTo": mailTo, "otpPassword": otpPassword});
    if (value.status == Status.SUCCESS) {
      return Resource.success(true);
    } else {
      return Resource.error(value.errorMessage!, value.statusCode);
    }
  }
}
