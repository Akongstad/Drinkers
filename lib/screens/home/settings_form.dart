import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/user.dart';
import 'package:flutter_firebase_app/services/dataBase.dart';
import 'package:flutter_firebase_app/shared/constants.dart';
import 'package:flutter_firebase_app/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> drinks = ['Water', 'Håndgranat', 'Skivand', 'Dansevand', 'Grøn', 'Cosmo'];

  String? _currentName;
  String? _currentDrink;
  int? _currentStrength;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserEntity?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData? userData = snapshot.data;
        return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Text('Update your settings',
                style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: userData!.name ?? 'Name',
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() { _currentName = val;
                  }),
                ), SizedBox(height: 20.0,),
                //dropdown
                DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentDrink ?? userData.drink,
                    items: drinks.map((drink) => DropdownMenuItem(
                      value: drink,
                      child: Text(drink),
                      )
                    ).toList(),
                    onChanged: (val) => setState(() {_currentDrink = val as String?;}),
                    ),
                const SizedBox(height: 20.0,),
                Slider(
                    activeColor: (_currentStrength ?? userData.strength!) < 500 ? Colors.yellow[_currentStrength ?? userData.strength!] : Colors.orange[_currentStrength ?? userData.strength!],
                    inactiveColor: (_currentStrength ?? userData.strength!) < 500 ? Colors.yellow[_currentStrength ?? userData.strength!] : Colors.orange[_currentStrength ?? userData.strength!],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    value: (_currentStrength ?? userData.strength!).toDouble(),
                    onChanged: (val) => setState(() { _currentStrength = val.round();}),
                    ),
                ElevatedButton(
                    onPressed: () async{
                      if(_formKey.currentState!.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                        _currentDrink ?? userData.drink ?? 'Water',
                        _currentName ?? userData.name ?? 'Anonymous',
                        _currentStrength ?? userData.strength ?? 100);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                ),
              ],
            ),
        );
        }  else {
          return const Loading();
        }
      },
    );
  }
}
