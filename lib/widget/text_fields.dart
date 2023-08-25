// ignore_for_file: must_be_immutable

import 'package:bwy/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatelessWidget {
  String? Function(String?) validatorCallback;
  TextEditingController controller;
  String labelText;
  bool isSecure;
  int? maxLength;
  bool? isEnable;
  bool? displayEye;
  void Function(String)? onChanged;

  MyTextFieldWidget({
    super.key,
    required this.validatorCallback,
    required this.controller,
    required this.labelText,
    this.isSecure = false,
    this.maxLength,
    this.isEnable = true,
    this.onChanged,
    this.displayEye = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   FocusScope.of(context).unfocus();
      // },
      child: TextFormField(
        cursorColor: CustomColors.bwyRed,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        validator: validatorCallback,
        onChanged: onChanged,
        controller: controller,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.white),
        obscureText: isSecure,
        enabled: isEnable,
        decoration: InputDecoration(
          // suffixIcon: displayEye,
          filled: true,
          fillColor: Colors.white12,
          labelText: labelText,
          counterText: (maxLength == null) ? '' : '${controller.text.length}/$maxLength',
          counterStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            // Burada OutlineInputBorder kullanıyoruz
            borderRadius: BorderRadius.circular(15.0), // İstediğiniz yuvarlaklık derecesini belirleyebilirsiniz
            borderSide: BorderSide.none, // Kenar çizgisi olmadan yalnızca arka plan rengi
          ),
          focusedBorder: OutlineInputBorder(
            // Odaklandığında kullanılacak kenar çizgisi
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: CustomColors.bwyRed), // Kenar çizgisi rengi
          ),
          floatingLabelStyle: TextStyle(color: Colors.white60),
          hintStyle: TextStyle(color: Colors.white10),
        ),
      ),
    );
  }
}
