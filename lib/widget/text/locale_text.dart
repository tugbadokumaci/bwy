import 'package:auto_size_text/auto_size_text.dart';
import 'package:bwy/extension/string_extension.dart';
import 'package:flutter/material.dart';

class LocaleTextCustom extends StatelessWidget {
  final String text;
  LocaleTextCustom({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(text.locale);
  }
}// LocaleTextCustom(text: LocaleKeys.home_appBarTitle)