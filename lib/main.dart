import 'package:booking_app/modules/Constants.dart';
import 'package:booking_app/modules/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/Provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Providerr>(create: (_) => Providerr()),
      ],
      child: Consumer<Providerr>(
        builder: (BuildContext context, provider, Widget child) {
          return MaterialApp(
            theme: provider.darkOn ? DarkTheme : LightTheme,
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
