import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:imovies/screen/get_started.dart';
import 'package:imovies/screen/home_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:imovies/screen/login_screen.dart';
import 'package:imovies/screen/sign_up.dart';
import 'package:flutter/services.dart';
void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false ,
      home: const GetStarted(),
      routes: {
        GetStarted.id : (context) => const GetStarted(),
        HomeScreen.id : (context) => const HomeScreen(),
        SignIn.id     : (context) => const SignIn(),
        SignUp.id     : (context) => const SignUp()

      },
    );
  }
}

