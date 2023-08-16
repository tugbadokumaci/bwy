import 'package:bwy/bloc/services_page/services_repository.dart';
import 'package:bwy/bloc/services_page/services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final ServicesRepository _repo;

  ServicesCubit({
    required ServicesRepository repo,
  })  : _repo = repo,
        super(ServicesInitial());
}
