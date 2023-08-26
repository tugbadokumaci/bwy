import 'package:flutter/material.dart';

import '../size_config.dart';

class MyTagContainer extends StatelessWidget {
  final String tagTitle;
  Color? borderColor;
  Color? textColor;
  MyTagContainer({super.key, required this.tagTitle, this.borderColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), border: Border.all(color: borderColor ?? Colors.white)),
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(tagTitle,
              style: TextStyle(
                  // color: CustomColors.bwyRedPastel,
                  color: textColor ?? Colors.white,
                  fontSize: SizeConfig.defaultSize! * 1.7,
                  fontWeight: FontWeight.bold))),
    );
  }
}
