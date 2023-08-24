import 'package:bwy/bloc/signup_page/signup_repository.dart';
import 'package:bwy/bloc/signup_page/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/user_model.dart';
import '../../shared_preferences_service.dart';
import '../../constants/constants.dart';
import '../../utils/resource.dart';
import '../../utils/utils.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepository _repo;
  SignupCubit({
    required SignupRepository repo,
  })  : _repo = repo,
        super(SignupInitial());

  TextEditingController getNameController = TextEditingController();
  TextEditingController getSurnameController = TextEditingController();

  TextEditingController getEmailController = TextEditingController();
  TextEditingController getPasswordController = TextEditingController();

  Future<void> signup(BuildContext context) async {
    if (getNameController.text == '') {
      Fluttertoast.showToast(
        msg: 'isim alanı boş olamaz',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else if (getSurnameController.text == '') {
      Fluttertoast.showToast(
        msg: 'soyisim alanı boş olamaz',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else if (getEmailController.text == '') {
      Fluttertoast.showToast(
        msg: 'email alanı boş olamaz',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else if (getPasswordController.text == '') {
      Fluttertoast.showToast(
        msg: 'şifre alanı boş olamaz',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else {
      emit(SignupLoading());
      Resource<UserModel> resource = await _repo.register(
          getNameController.text, getSurnameController.text, 0, getEmailController.text, getPasswordController.text);

      if (resource.status == Status.SUCCESS) {
        Constants.USER = resource.data!;
        await SharedPreferencesService.setStringPreference(getEmailController.text, getPasswordController.text);
        emit(SignupSuccess());
        Fluttertoast.showToast(
          msg: 'Signup Success',
          backgroundColor: Colors.green,
          gravity: ToastGravity.TOP,
        );
        // Navigator.pushReplacementNamed(context, homeRoute);
      } else {
        Utils.showCustomDialog(
          context: context,
          title: 'Sign upError',
          content: resource.errorMessage ?? '',
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, '/signUp');
          },
        );
      }
    }
  }
}
