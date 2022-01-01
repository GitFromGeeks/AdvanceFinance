import 'screens/add_customer.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Advance Finance",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      home: SplashScreen(),
      routes: {
        "/home": (context) => Home(),
        "/login": (context) => LoginScreen(),
        "/add_customer": (context) => Add_customer(),
      },
    );
  }
}
