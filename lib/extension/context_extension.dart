import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHeight(double val) => MediaQuery.of(this).size.height * val;

  ThemeData get theme => Theme.of(this);
}

extension NumberExtension on BuildContext {
  double get smallValue => dynamicHeight(0.01);
  double get mediumValue => dynamicHeight(0.03);
  double get largeValue => dynamicHeight(0.05);
}

extension ButtonExtension on BuildContext {
  double get buttonWidth => dynamicWidth(0.8);
  double get buttonHeight => dynamicHeight(0.06);
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingAllSmall => EdgeInsets.all(smallValue);
  EdgeInsets get paddingAllMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingAllLarge => EdgeInsets.all(largeValue);
}

extension EmptyWidget on BuildContext {
  Widget get emptyWidgetHeight => SizedBox(height: smallValue);
}
