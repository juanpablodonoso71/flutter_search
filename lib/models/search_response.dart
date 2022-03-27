import 'dart:convert';

import 'package:search/models/cliente.dart';

class SearchResponse {
  SearchResponse({
    required this.apellido,
    //this.picture,
  });

  //String apellido;
  List<Cliente> apellido;
  //String? picture;

  factory SearchResponse.fromJson(String str) =>
      SearchResponse.fromMap(json.decode(str));

  factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        apellido:
            List<Cliente>.from(json["apellido"].map((x) => Cliente.fromMap(x))),
        //picture: json["picture"],
      );
}
