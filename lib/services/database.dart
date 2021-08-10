import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/brew.dart';

abstract class DatabaseContracts {
  Future updateUserData({
    required String sugars,
    required String name,
    required int strength,
  });
}

class DatabaseService implements DatabaseContracts {
  final String? uid;

  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  @override
  Future updateUserData({
    required String sugars,
    required String name,
    required int strength,
  }) async {
    return await brewCollection.doc(uid!).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc['name'] ?? '',
        sugars: doc['sugars'] ?? '0',
        strength: doc['strength'] ?? 0,
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return UserData(
      uid: uid!,
      name: data['name'],
      sugars: data['sugars'],
      strength: data['strength'],
    );
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid!).snapshots().map(_userDataFromSnapshot);
  }
}
