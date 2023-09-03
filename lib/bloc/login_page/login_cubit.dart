// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/user_model.dart';
import '../../shared_preferences_service.dart';
import '../../constants/constants.dart';
import '../../utils/resource.dart';
import '../../utils/utils.dart';
import 'login_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _repo;

  LoginCubit({
    required LoginRepository repo,
  })  : _repo = repo,
        super(LoginInitial());

  TextEditingController getEmailController = TextEditingController();
  TextEditingController getPasswordController = TextEditingController();

  Future<void> initialize() async {
    getEmailController.text = await SharedPreferencesService.getEmailPreference();
    getPasswordController.text = await SharedPreferencesService.getPasswordPreference();
  }

  // Future<void> toStep2() async {
  //   if (getEmailController.text == '') {
  //     Fluttertoast.showToast(
  //       msg: 'email field cant be null',
  //       backgroundColor: Colors.redAccent,
  //       gravity: ToastGravity.TOP,
  //     );
  //     emit(LoginInitial());
  //   } else {
  //     emit(LoginStep2());
  //   }
  // }

  Future<void> login(BuildContext context) async {
    if (!EmailValidator.validate(getEmailController.text)) {
      Fluttertoast.showToast(
        msg: 'Emailiniz boş veya geçersiz olamaz',
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
      emit(LoginLoading());
      final email = getEmailController.text;
      final password = getPasswordController.text;

      Resource<UserModel> resource = await _repo.login(email, password);

      if (resource.status == Status.SUCCESS) {
        Constants.USER = resource.data!;
        await SharedPreferencesService.setStringPreference(email, password);

        Fluttertoast.showToast(
          msg: 'Giriş Başarılı',
          backgroundColor: Colors.green,
          gravity: ToastGravity.TOP,
        );
        emit(LoginSuccess());
        // Navigator.pushNamed(context, '/home');
      } else if (resource.statusCode == 403) {
        // inactive account error

        Utils.showCustomDialog(
          // context: context,
          title: 'Doğrulanmamış hesap',
          content: 'Email doğrulamaya yönlendiriliyorsunuz',
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, '/validation', arguments: {'email': email, 'password': password});
          },
        );
      } else {
        Utils.showCustomDialog(
          // context: context,
          title: 'Giriş Başarısız',
          content: resource.errorMessage ?? '',
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, '/logIn');
          },
        );
      }
    }
  }
}
