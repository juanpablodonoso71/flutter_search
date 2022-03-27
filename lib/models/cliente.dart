import 'dart:convert';

class Cliente {
  Cliente({
    required this.apellido,
    required this.name,
    required this.altura,
    required this.peso,
    this.picture,
    this.id,
    required this.available,
  });

  String name;
  String apellido;
  double altura;
  double peso;
  String? picture;
  String? id;
  bool available;

  factory Cliente.fromJson(String str) => Cliente.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cliente.fromMap(Map<String, dynamic> json) => Cliente(
        name: json["name"],
        apellido: json["apellido"],
        picture: json["picture"],
        altura: json["altura"].toDouble(),
        peso: json["peso"].toDouble(),
        available: json["available"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "apellido": apellido,
        "picture": picture,
        "altura": altura,
        "peso": peso,
        "available": available,
      };

  Cliente copy() => Cliente(
      name: this.name,
      apellido: this.apellido,
      picture: this.picture,
      altura: this.altura,
      id: this.id,
      peso: this.peso,
      available: this.available);
}
