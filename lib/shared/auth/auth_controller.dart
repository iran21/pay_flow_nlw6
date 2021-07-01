import 'package:flutter/material.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  bool _isAuthenticated = false;
  UserModel? _user;

  get user => _user!;

///Método para avaliar se usuário já está logado, recebe um objeto UserModel
  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      _isAuthenticated = true;
      _user = user;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

///Método para salvar dados do usuário já logado
  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString('user', user.toJson());
  }

///Método para recuperar os dados do usuário da memória
  Future<void> currentUser(BuildContext context, UserModel user)async{
    final instance = await SharedPreferences.getInstance();
    final json = instance.getString("user") as String;
    setUser(context, UserModel.fromJson(json));
  }
}
