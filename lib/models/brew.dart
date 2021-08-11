class Brew {
  final String name;
  final String sugars;
  final int strength;

  Brew({
    required this.name,
    required this.sugars,
    required this.strength,
  });

  factory Brew.fromJson(dynamic json) {
    return Brew(
      name: json['name'] ?? '',
      sugars: json['sugars'] ?? '0',
      strength: json['strength'] ?? 0,
    );
  }
}
