import 'package:drivo/controllers/auth_controller.dart';
import 'package:drivo/core/log.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const id = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              var token = AuthController.readToken();
              if (token != null) {
                Log.verbose(token.refreshExpiresIn);
              }
            },
            child: const Text('CLICK ME')),
      ),
    );
  }
}
