import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class DrinkList extends StatefulWidget {
  const DrinkList({Key? key}) : super(key: key);

  @override
  _DrinkListState createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  @override
  Widget build(BuildContext context) {
    final drinks = Provider.of<QuerySnapshot>(context);
    //print(drinks.docs);
    for (var doc in drinks.docs){
      print(doc.data());
    }


    return Container();
  }
}
