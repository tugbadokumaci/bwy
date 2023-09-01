import 'package:bwy/bloc/validation_page/vaildation_repository.dart';
import 'package:bwy/bloc/validation_page/validation_state.dart';
import 'package:bwy/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../navigator_key.dart';
import '../../shared_preferences_service.dart';
import '../../utils/resource.dart';
import '../../utils/utils.dart';

class VerificationCodeController {
  final List<TextEditingController> digitControllers = List.generate(4, (_) => TextEditingController());
}

class ValidationCubit extends Cubit<ValidationState> {
  final ValidationRepository _repo;

  ValidationCubit({
    required ValidationRepository repo,
  })  : _repo = repo,
        super(ValidationInitial());

  final VerificationCodeController verificationController = VerificationCodeController();

  // validation açıldığında çalışacak
  Future<void> sendOtp(String emailTo) async {
    final isSent = await _repo.sendOtp(emailTo);
    if (isSent.status == Status.SUCCESS) {
      Utils.showCustomDialog(
        title: 'Hesabınızı doğrulayın',
        content: 'Hesabınızı aktifleştirmek için email adresinize doğrulama kodu gönderildi.',
        onTap: () {
          Navigator.of(navigatorKey.currentContext!).pop();
        },
      );
    } else {
      Utils.showCustomDialog(
        title: 'Hata',
        content: isSent.errorMessage ?? 'Kayıt işlemi sırasında hata gerçekleşti',
        onTap: () {
          Navigator.of(navigatorKey.currentContext!).pop();
          Navigator.pushNamed(navigatorKey.currentContext!, '/welcome');
        },
      );
    }
  }

  Future<void> validate(BuildContext context, String email, String password) async {
    emit(ValidationLoading());
    String userOtpInput =
        verificationController.digitControllers.map((controller) => controller.text).join('').toString();
    final result = await _repo.validateOtp(email, userOtpInput);
    if (result.status == Status.SUCCESS) {
      Fluttertoast.showToast(
        msg: 'Hesabınız onaylandı',
        backgroundColor: Colors.green,
        gravity: ToastGravity.TOP,
      );
      final result = await _repo.login(email, password);

      if (result.status == Status.SUCCESS) {
        await SharedPreferencesService.setStringPreference(result.data!.userEmail, result.data!.userPassword);
        Constants.USER = result.data!;
        emit(ValidationSuccess());
        // Navigator.pushNamed(context, "/home");
      } else {
        Fluttertoast.showToast(
          msg: 'Hesabınıza giriş yaparken sorun yaşandı',
          backgroundColor: Colors.redAccent,
          gravity: ToastGravity.TOP,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Hatalı onay kodu',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
      emit(ValidationInitial());
    }
  }
}
