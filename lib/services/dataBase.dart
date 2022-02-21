import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});

  //Collection reference
  final CollectionReference drinkCollection = FirebaseFirestore.instance.collection('drinks');

  Future updateUserData(String drink, String name, int strength) async {
    return await drinkCollection.doc(uid).set({
      'drink' : drink,
      'name' : name,
      'strength' : strength,
    });
  }
}