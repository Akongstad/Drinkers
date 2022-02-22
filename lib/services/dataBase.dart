import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_app/models/drink.dart';

class DatabaseService{

  final String? uid;
  DatabaseService({this.uid});

  //Collection reference
  final CollectionReference drinkCollection = FirebaseFirestore.instance.collection('drinks');

  Future updateUserData(String drink, String name, int strength) async {
    return await drinkCollection.doc(uid).set({
      'drink' : drink,
      'name' : name,
      'strength' : strength,
    });
  }

  //list of drinks from snapshop
  List<Drink> _drinkListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Drink(
        name: doc.get('name') ?? '',
        strength: doc.get('strength') ?? 0,
        drink: doc.get('drink') ?? 'Water',
      );
    }).toList(growable: false);
  }

  Stream<QuerySnapshot> get drinks{
    return drinkCollection.snapshots();
  }
}