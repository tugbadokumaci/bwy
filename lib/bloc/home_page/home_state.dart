import '../../models/user_model.dart';
import '../../utils/resource.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final Resource<List<UserModel>> fetchResource;

  HomeSuccess({required this.fetchResource});
}

class HomeError extends HomeState {}
