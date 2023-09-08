import 'package:bwy/bloc/profile_page/profile_repository.dart';
import 'package:bwy/bloc/profile_page/profile_state.dart';
import 'package:bwy/extension/string_extension.dart';
import 'package:bwy/lang/locale_keys.g.dart';
import 'package:bwy/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/constants.dart';
import '../../utils/resource.dart';
import '../../utils/utils.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repo;
  ProfileCubit({
    required ProfileRepository repo,
  })  : _repo = repo,
        super(ProfileInitial());

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordAgainController = TextEditingController();

  Future<void> getProfile() async {
    emit(ProfileSuccess());
  }

  Future<void> goPasswordPage() async {
    emit(ProfilePasswordChange());
  }

  Future<void> deleteAccount(BuildContext context) async {
    Resource<bool> resource = await _repo.deleteAccount();
    if (resource.status == Status.SUCCESS) {
      Utils.showCustomDialog(
        // context: context,
        title: LocaleKeys.profile_success.locale,
        content: LocaleKeys.profile_deleteSuccess.locale,
        onTap: () async {
          await SharedPreferencesService.clearLocalStorage();
          Navigator.of(context).pop();
          Navigator.pushNamed(context, '/');
        },
      );
    } else {
      Utils.showCustomDialog(
        // context: context,
        title: LocaleKeys.profile_fail.locale,
        content: LocaleKeys.profile_deleteFail.locale,
        onTap: () {
          passwordAgainController.text == '';
          passwordController.text = '';
          emit(ProfileSuccess());
          Navigator.of(context).pop();
        },
      );
    }
  }

  Future<void> changePassword(BuildContext context) async {
    if (passwordController.text == '') {
      Fluttertoast.showToast(
        msg: 'Şifre alanı boş olamaz',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else if (passwordAgainController.text == '') {
      Fluttertoast.showToast(
        msg: 'Şifre tekrar alanı boş olamaz',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else if (passwordController.text != passwordAgainController.text) {
      Fluttertoast.showToast(
        msg: 'Şifre tekrarı hatalı',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else if (passwordController.text == Constants.USER.userPassword) {
      Fluttertoast.showToast(
        msg: 'Yeni şifre eskisi ile aynı olamaz',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else {
      emit(ProfileLoading());
      Resource<bool> resource = await _repo.changePassword(passwordController.text);
      if (resource.status == Status.SUCCESS) {
        // const güncelle
        Constants.USER.userPassword = passwordController.text;
        // shared preference güncelle
        SharedPreferencesService.setStringPreference(Constants.USER.userEmail, Constants.USER.userPassword);

        Utils.showCustomDialog(
          // context: context,
          title: 'Başarılı',
          content: 'Şifre Güncelleme Başarılı',
          onTap: () {
            passwordAgainController.text == '';
            passwordController.text = '';
            emit(ProfileSuccess());
            Navigator.of(context).pop();
          },
        );
      } else {
        Utils.showCustomDialog(
          // context: context,
          title: 'Şifreyi Güncellerken Hata Oluştu',
          content: resource.errorMessage ?? '',
          onTap: () {
            Navigator.of(context).pop();
            passwordAgainController.text == '';
            passwordController.text = '';
          },
        );
      }
    }
  }

  Future<void> logOut() async {
    emit(ProfileLoading());
    SharedPreferencesService.clearLocalStorage();
  }
}
