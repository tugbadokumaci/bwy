import '../../models/service_model.dart';
import '../../utils/resource.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final Resource<List<ServiceModel>> serviceResource;

  HomeSuccess({required this.serviceResource});
}

class HomeError extends HomeState {}
