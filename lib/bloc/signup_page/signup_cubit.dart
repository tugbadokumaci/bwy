import 'package:bwy/bloc/signup_page/signup_repository.dart';
import 'package:bwy/bloc/signup_page/signup_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:regexed_validator/regexed_validator.dart';

import '../../constants/constants.dart';
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
    } else if (!validator.phone(getPhoneController.text)) {
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
    } else {
      emit(SignupLoading());
      Resource<UserModel> resource = await _repo.register(
          getNameController.text, getSurnameController.text, 0, getEmailController.text, getPasswordController.text);

      if (resource.status == Status.SUCCESS) {
        // Constants.USER = resource.data!; // KULLANICI UYE OLDUGUNDA CONST KAYDEDİYOR
        emit(SignupSuccess());
        // Fluttertoast.showToast(
        //   msg: 'Signup Success',
        //   backgroundColor: Colors.green,
        //   gravity: ToastGravity.TOP,
        // );
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
}
