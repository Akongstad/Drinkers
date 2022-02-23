import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/drink.dart';

class DrinkTile extends StatelessWidget {

  final Drink drink;
  const DrinkTile({Key? key, required this.drink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.only(top: 8.0),
     child: Card(
       margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
       child: ListTile(
         leading: CircleAvatar(
           radius: 27.0,
           backgroundColor: drink.strength < 600 ? Colors.yellow[drink.strength] : Colors.red[drink.strength],
           backgroundImage: const AssetImage('cocktail.png'),
         ),
         title: Text(drink.name),
         subtitle: Text('Drink: ${drink.drink}'),
       ),
     ),
   );
  }
}
