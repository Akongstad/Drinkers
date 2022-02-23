import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/home/drink_list.dart';
import 'package:flutter_firebase_app/screens/home/settings_form.dart';
import 'package:flutter_firebase_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase_app/services/dataBase.dart';

import '../../models/drink.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Drink>>.value(
      value: DatabaseService().drinks,
      initialData: List<Drink>.empty(),
      child: Scaffold(
        backgroundColor: Colors.yellow[90],
        appBar: AppBar(
          title: const Text('Drinkers'),
          backgroundColor: Colors.amber,
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
                onPressed: () async {await _auth.signOut();},
                icon: const Icon(Icons.person),
                label: const Text('logout')),
            TextButton.icon(
                onPressed: () => _showSettingsPanel(),
                label: const Text('Settings'),
                icon: const Icon(Icons.settings),

            )
          ],
        ),
        body: DrinkList(),
      ),
    );
  }
}
