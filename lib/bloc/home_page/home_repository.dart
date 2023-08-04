import '../../inheritance/mixin_user_feature.dart';
import '../../utils/generator.dart';

class HomeRepository with MixinUserFeature {
  RestClient client;
  HomeRepository(this.client);
}
