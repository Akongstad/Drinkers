import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/drink.dart';
import 'package:provider/provider.dart';
import 'drink_tile.dart';

class DrinkList extends StatefulWidget {
  const DrinkList({Key? key}) : super(key: key);

  @override
  _DrinkListState createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  @override
  Widget build(BuildContext context) {
    final drinks = Provider.of<List<Drink>>(context);
    //print(drinks.docs);
    drinks.forEach((drink) {
      print(drink.name);
      print(drink.drink);
      print(drink.strength);
    });
    return ListView.builder(
      itemCount: drinks.length,
      itemBuilder: (context, index){
        return DrinkTile(drink : drinks[index]);
      },
    );
  }
}
