import 'dart:convert';

/// classe do tipo DataModel, que faz conversão de tipos(String pra Json e mapas)
class UserModel {
  final String name;
  final String? photoURL;

  UserModel({required this.name, this.photoURL});

//Métodos parse!!

  ///Método que cria um mapa a partir dos parâmetros da classe
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'photoURL': photoURL,
    };
  }

  ///Método que retorna uma string com estrtutura de um objeto json
  String toJson() {
    return jsonEncode(toMap());
  }

  ///Método factory que recebe a String com estrtutura JSON, e a transformará em um objeto json
  factory UserModel.fromJson(String json) {
    return UserModel.fromMap(jsonDecode(json));
  } 

  ///Método que recebe um mapa e retorna a instância de [UserModel]
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(name: map['name'], photoURL: map['photoURL']);
  }
}
