import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:turu/view/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 67, 127, 224),
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}
