import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/brew.dart';
import '../../models/user.dart';

abstract class BrewDatabaseContracts {
  Future updateData({
    required String sugars,
    required String name,
    required int strength,
  });

  Future addData({
    required String sugars,
    required String name,
    required int strength,
  });
}

class BrewDatabaseService implements BrewDatabaseContracts {
  final String? uid;

  BrewDatabaseService({this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((e) => Brew.fromJson(e)).toList();
    });
  }

  Stream<UserBrewData> get userBrewData {
    return brewCollection
        .doc(uid!)
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      final data = snapshot.data()! as Map<String, dynamic>;
      return UserBrewData.fromJson(uid: uid!, json: data);
    });
  }

  @override
  Future updateData({
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

  @override
  Future addData({
    required String sugars,
    required String name,
    required int strength,
  }) async {
    return await brewCollection.add({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }
}
