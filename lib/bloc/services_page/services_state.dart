abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesSuccess extends ServicesState {
  // final Resource<List<UserModel>> fetchResource;

  // ServicesSuccess({required this.fetchResource});
}

class ServicesError extends ServicesState {}
