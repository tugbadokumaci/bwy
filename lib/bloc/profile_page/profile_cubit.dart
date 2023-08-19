import 'package:bwy/bloc/profile_page/profile_repository.dart';
import 'package:bwy/bloc/profile_page/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repo;
  ProfileCubit({
    required ProfileRepository repo,
  })  : _repo = repo,
        super(ProfileInitial());
  Future<void> getProfile() async {
    return emit(ProfileSuccess());
  }
}
