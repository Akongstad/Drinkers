import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[90],
      appBar: AppBar(
        title: const Text('Drinkers'),
        backgroundColor: Colors.amber,
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              onPressed: () async {await _auth.signOut();},
              icon: const Icon(Icons.person),
              label: const Text('logout'))
        ],
      ),
    );
  }
}
