import 'package:flutter/material.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

  get user => _user!;

  ///Método que recebe [BuildContext] e [UserModel] para avaliar se o user ja foi logado alguma vez
  bool checkUser(BuildContext context, UserModel? user) {
    if (user != null) {
      _user = user;
      Navigator.pushReplacementNamed(context, '/home');
      return true;
    } else {
      Navigator.pushReplacementNamed(context, '/login');
      return false;
    }
  }

  ///Método para salvar dados do usuário que logou
  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString('user', user.toJson());
  }

  ///Método para recuperar os dados do usuário da memória
  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    bool hasKey = instance.containsKey('user');
    if (hasKey) {
      final json = instance.getString('user') as String;
      checkUser(context, UserModel.fromJson(json));
      return;
    } else {
      checkUser(context, null);
    }
  }
}
