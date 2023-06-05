import 'package:flutter/material.dart';
import 'package:flutter_remote_enverioments_firebase/auth/auth_service.dart';
import 'package:flutter_remote_enverioments_firebase/firebase_remote_config_service.dart';
import 'package:flutter_remote_enverioments_firebase/pages/initial_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = AuthService().isUserLoggedIn();

    if (!isLoggedIn) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Acesso restrito'),
            content:
                const Text('Por favor, faça login para acessar esta tela.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const InitialScreen()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(FirebaseRemoteConfigServe().getString('username'))),
          Center(
              child: Text(FirebaseRemoteConfigServe().getString('password'))),
          ElevatedButton(
            onPressed: () {
              AuthService().logoutUser();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const InitialScreen()),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
