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
  TextInputType keyboardType;
  void Function(String)? onChanged;

  MyTextFieldWidget({
    super.key,
    required this.validatorCallback,
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    this.isSecure = false,
    this.maxLength,
    this.isEnable = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 350, // Set your maximum width here
      ),
      child: GestureDetector(
        // onTap: () {
        //   FocusScope.of(context).unfocus();
        // },
        child: TextFormField(
          // cursorColor: CustomColors.bwyRed,
          cursorColor: Colors.white,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          validator: validatorCallback,
          onChanged: onChanged,
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: Colors.white),
          obscureText: isSecure,
          enabled: isEnable,
          decoration: InputDecoration(
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
              // borderSide: BorderSide(color: CustomColors.bwyRed),
              borderSide: BorderSide(color: CustomColors.lightGray),
            ),
            floatingLabelStyle: TextStyle(color: Colors.white60),
            hintStyle: TextStyle(color: Colors.white10),
          ),
        ),
      ),
    );
  }
}
