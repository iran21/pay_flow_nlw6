import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';

class LoginController {
  final AuthController authController = AuthController();

  Future<void> googleSignIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final response = (await _googleSignIn.signIn())!;

      final user =
          UserModel(name: response.displayName!, photoURL: response.photoUrl);

      authController.checkUser(context, user)
          ? authController.saveUser(user)
          : print('ja logado');

      print(response);
    } catch (e) {
      authController.checkUser(context, null);
      print(e);
    }
  }
}
