import 'package:bwy/bloc/signup_page/signup_repository.dart';
import 'package:bwy/bloc/signup_page/signup_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:regexed_validator/regexed_validator.dart';

import '../../models/user_model.dart';
import '../../navigator_key.dart';
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
  TextEditingController getPhoneController = TextEditingController();
  TextEditingController getEmailController = TextEditingController();
  TextEditingController getPasswordController = TextEditingController();
  bool isChecked = false;

  Future<void> signup(BuildContext context) async {
    if (getNameController.text.length < 3) {
      Fluttertoast.showToast(
        msg: 'İsim 3 karakterden kısa olamaz',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else if (getSurnameController.text.length < 3) {
      Fluttertoast.showToast(
        msg: 'Soyisim 3 karakterden kısa olamaz',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else if (!validateMobile(getPhoneController.text)) {
      Fluttertoast.showToast(
        msg: 'Telefon numarası boş veya geçersiz',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else if (!EmailValidator.validate(getEmailController.text)) {
      Fluttertoast.showToast(
        msg: 'Emailiniz boş veya geçersiz olamaz',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else if (getPasswordController.text.length < 6) {
      Fluttertoast.showToast(
        msg: 'şifreniz 6 karakterden kısa olamaz',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else if (!isChecked) {
      Fluttertoast.showToast(
        msg: 'KVKK metnini onaylayınız',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else {
      emit(SignupLoading());
      Resource<UserModel> resource = await _repo.register(getNameController.text, getSurnameController.text, 0,
          getPhoneController.text, getEmailController.text, getPasswordController.text);

      if (resource.status == Status.SUCCESS) {
        emit(SignupSuccess());
      } else {
        Utils.showCustomDialog(
          // context: context,
          title: 'Sign upError',
          content: resource.errorMessage ?? '',
          onTap: () {
            Navigator.of(navigatorKey.currentContext!).pop();
            Navigator.pushReplacementNamed(context, '/signUp');
          },
        );
      }
    }
  }

  bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
}
