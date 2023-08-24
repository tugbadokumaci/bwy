abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
//   final Resource<List<UserModel>> fetchResource;

//   ProfileSuccess({required this.fetchResource});
}

class ProfilePasswordChange extends ProfileState {}

class ProfileError extends ProfileState {}
