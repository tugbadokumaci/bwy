import 'package:bwy/bloc/home_page/home_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';
import '../../utils/resource.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repo;

  late Resource<List<UserModel>> userResource;
  late Resource<List<UserModel>> fetchResource;
  late Resource<UserModel> createResource;
  HomeCubit({
    required HomeRepository repo,
  })  : _repo = repo,
        super(HomeInitial());

  Future<void> getData() async {
    emit(HomeLoading());
    userResource = await _repo.getData();
    if (userResource.status == Status.SUCCESS) {
      emit(HomeSuccess(fetchResource: userResource));
      debugPrint('get data success');
    } else {
      debugPrint('Error while fetching get user data');
      emit(HomeError());
    }
  }

  // Future<void> fetchData() async {
  //   emit(HomeLoading());
  //   fetchResource = await _repo.fetchData();
  //   if (fetchResource.status == Status.SUCCESS) {
  //     emit(HomeSuccess(fetchResource: fetchResource));
  //   } else {
  //     debugPrint('Error while fetching get user data');
  //     emit(HomeError());
  //   }
  // }

  // Future<void> createUser() async {
  //   createResource = await _repo.register(
  //     "flutter",
  //     "flutter",
  //     666,
  //     "flutter",
  //     "flutter",
  //   );
  //   if (createResource.status == Status.SUCCESS) {
  //     debugPrint('createUser success');
  //   } else {
  //     debugPrint('createUser error');
  //   }
  // }
}
