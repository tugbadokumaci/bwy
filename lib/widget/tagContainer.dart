import 'package:flutter/material.dart';

import '../size_config.dart';

class MyTagContainer extends StatelessWidget {
  final String tagTitle;

  const MyTagContainer({required this.tagTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white)),
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(tagTitle,
              style: TextStyle(
                  // color: CustomColors.bwyRedPastel,
                  color: Colors.white,
                  fontSize: SizeConfig.defaultSize! * 1.7,
                  fontWeight: FontWeight.bold))),
    );
  }
}
