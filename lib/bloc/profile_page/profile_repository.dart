import '../../constants/constants.dart';
import '../../inheritance/mixin_user_feature.dart';
import '../../models/user_model.dart';
import '../../utils/generator.dart';
import '../../utils/resource.dart';

class ProfileRepository with MixinUserFeature {
  RestClient client;
  ProfileRepository(this.client);
  Future<Resource<bool>> changePassword(String newPassword) async {
    final restClient = RestClient.create();
    var value = await restClient.changePassword({
      "userId": Constants.USER.userId,
      "newPassword": newPassword,
    });
    if (value.status == Status.SUCCESS) {
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!);
    }
  }
}
