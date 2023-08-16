import 'package:bwy/inheritance/mixin_user_feature.dart';

import '../../utils/generator.dart';

class LoginRepository with MixinUserFeature {
  RestClient client;
  LoginRepository(this.client);
}
