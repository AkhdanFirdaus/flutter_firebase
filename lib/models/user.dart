class User {
  final String uid;

  User({required this.uid});
}

class UserBrewData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserBrewData({
    required this.uid,
    required this.name,
    required this.sugars,
    required this.strength,
  });

  factory UserBrewData.fromJson({
    required String uid,
    required Map<String, dynamic> json,
  }) {
    return UserBrewData(
      uid: uid,
      name: json['name'],
      sugars: json['sugars'],
      strength: json['strength'],
    );
  }
}
