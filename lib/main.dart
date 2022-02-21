import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/user.dart';
import 'package:flutter_firebase_app/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_app/services/auth.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserEntity?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
       home: Wrapper(),
      ),
    );
  }
}
