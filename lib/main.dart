import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_remote_enverioments_firebase/pages/home_screen.dart';
import 'package:flutter_remote_enverioments_firebase/pages/initial_screen.dart';
import 'package:flutter_remote_enverioments_firebase/pages/login_page.dart';
import 'package:flutter_remote_enverioments_firebase/pages/sing_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => InitialScreen(),
        '/signup': (context) => SingUp(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
