import 'package:bwy/routes.dart';
import 'package:bwy/service_locator.dart';
import 'package:bwy/shared_preferences_service.dart';
import 'package:bwy/utils/constants.dart';
import 'package:bwy/utils/custom_colors.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection();
  await SharedPreferencesService.initialize();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(centerTitle: true, backgroundColor: Colors.transparent, elevation: 0.0),
        primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
        textTheme: Typography(platform: TargetPlatform.iOS).white,
        // textTheme: Typography.whiteCupertino,
        // colorScheme: const ColorScheme.light().copyWith(primary: Colors.red),
        bottomAppBarTheme: const BottomAppBarTheme(shape: CircularNotchedRectangle()),
        progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.red),
        iconTheme: IconThemeData(color: CustomColors.bwyRed),
        // inputDecorationTheme: InputDecorationTheme(
        //   filled: true,
        //   fillColor: CustomColors.darkGrey,
        //   border: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(10),
        //     borderSide: BorderSide.none,
        //   ),
        //   focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(10),
        //     borderSide: BorderSide.none,
        //   ),
        // ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: NoAnimationPageTransitionsBuilder(),
            TargetPlatform.iOS: NoAnimationPageTransitionsBuilder(),
          },
        ),
      ),
      onGenerateRoute: RouteGenerator.GenerateRoute,
      initialRoute: welcomeRoute,
    );
  }
}

class NoAnimationPageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child; // No animation, return the child directly
  }
}
