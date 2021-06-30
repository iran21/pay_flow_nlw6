import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';

class LoginController {
  final AuthController authController =  AuthController();
  Future<void> googleSignIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
    var response;
    try {
      response = await _googleSignIn.signIn();
      authController.setUser(context, response);
      print(response);
    } catch (e) {
      authController.setUser(context, null);
      print(e);
    }
  }
}
