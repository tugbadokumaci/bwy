import '../../inheritance/mixin_user_feature.dart';
import '../../models/service_model.dart';
import '../../utils/constants.dart';
import '../../utils/generator.dart';
import '../../utils/resource.dart';

class HomeRepository with MixinUserFeature {
  RestClient client;
  HomeRepository(this.client);

  Future<Resource<List<ServiceModel>>> getServices() async {
    final restClient = RestClient.create();
    var value = await restClient.getServices({"userId": Constants.USER.userId});
    if (value.status == Status.SUCCESS) {
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!);
    }
  }
}
