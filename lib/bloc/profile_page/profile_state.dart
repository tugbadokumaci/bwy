abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
//   final Resource<List<UserModel>> fetchResource;

//   ProfileSuccess({required this.fetchResource});
}

class ProfileError extends ProfileState {}
