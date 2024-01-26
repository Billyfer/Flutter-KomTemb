import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'dasboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  FirebaseOptions firebaseOptions = FirebaseOptions(
      apiKey: "AIzaSyA3Bz6mBTk2D6VXmdIC-n93ABZxIFcxAIs",
      authDomain: "komtemb.firebaseapp.com",
      databaseURL:
          "https://komtemb-default-rtdb.asia-southeast1.firebasedatabase.app",
      projectId: "komtemb",
      storageBucket: "komtemb.appspot.com",
      messagingSenderId: "733286684302",
      appId: "1:733286684302:web:e708f5dc6ae47022869bdf",
      measurementId: "G-YP153K6LNP");

  await Firebase.initializeApp(options: firebaseOptions);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/Dashboard': (context) => DashboardPage(),
        '/newcomic': (context) => DashboardPage(),
      },
    );
  }
}
