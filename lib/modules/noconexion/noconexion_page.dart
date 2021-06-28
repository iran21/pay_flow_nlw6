import 'package:flutter/material.dart';

class NoConexionPage extends StatelessWidget {
  const NoConexionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Sem Conexão'),
        ),
      ),
    );
  }
}
