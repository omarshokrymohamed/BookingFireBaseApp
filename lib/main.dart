import 'package:booking_app/modules/splash/splash_screen.dart';
import 'package:booking_app/shared/commponents/commponents.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
scaffoldBackgroundColor: kScaffoldColor,

      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,

    );
  }
}
