import 'package:flutter/material.dart';
import 'package:flutter_remote_enverioments_firebase/firebase_remote_config_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(FirebaseRemoteConfigServe().getString('username'))),
          Center(
              child: Text(FirebaseRemoteConfigServe().getString('password'))),
        ],
      ),
    );
  }
}
