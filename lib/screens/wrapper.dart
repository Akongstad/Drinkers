import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/user.dart';
import 'package:flutter_firebase_app/screens/authenticate/authenticate.dart';
import 'package:flutter_firebase_app/screens/home/home.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserEntity?>(context);
    //return home or authmwidget;
    if(user == null) {
      return Authenticate();
    }
    return Home();
  }
}
