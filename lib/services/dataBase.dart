import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_app/models/drink.dart';
import 'package:flutter_firebase_app/models/user.dart';

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

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.get('name'),
      drink: snapshot.get('drink'),
      strength: snapshot.get('strength')
    );
  }

  Stream<List<Drink>> get drinks{
    return drinkCollection.snapshots()
    .map((event) => _drinkListFromSnapshot(event));
  }

  //get user doc strem
  Stream<UserData> get userData {
    return drinkCollection.doc(uid).snapshots().map((snapshot) => _userDataFromSnapshot(snapshot));
  }
}