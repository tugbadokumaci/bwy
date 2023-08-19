import 'package:flutter/cupertino.dart';

Future<void> navigateToNewRoute(
  BuildContext context,
  String newRouteName,
  Object? arguments,
) async {
  final currentRoute = ModalRoute.of(context)?.settings.name;
  debugPrint(currentRoute); // null
  debugPrint(newRouteName);
  if (currentRoute != newRouteName) {
    await Navigator.pushReplacementNamed(context, newRouteName, arguments: arguments);
  }
}
