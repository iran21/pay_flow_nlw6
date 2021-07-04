import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode/barcode_scanner_page.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/noconexion/noconexion_page.dart';
import 'package:payflow/modules/splash/splash_page.dart';
import 'package:payflow/shared/theme/app_colors.dart';

void main() {
  runApp(AppFirebase());
}

class AppFirebase extends StatefulWidget {
  const AppFirebase({Key? key}) : super(key: key);

  @override
  _AppFirebaseState createState() => _AppFirebaseState();
}

class _AppFirebaseState extends State<AppFirebase> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return NoConexionPage();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return AppWidget();
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pay Flow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: AppColors.primary, primarySwatch: Colors.orange),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => SplashPage(),
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/barcode_scanner': (context) => BarcodeScannerPage()
        });
  }
}
