import 'package:admin_web_portal/authentication/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:admin_web_portal/main_screens/home_screen.dart';

Future<void> main() async
{
  FirebaseOptions options = const FirebaseOptions(
      apiKey: "AIzaSyBV72VxE93MO-NFx8z55JVSNdxeMFQysus",
      authDomain: "oncampusdelivery12.firebaseapp.com",
      projectId: "oncampusdelivery12",
      storageBucket: "oncampusdelivery12.appspot.com",
      messagingSenderId: "297446362028",
      appId: "1:297446362028:web:739dbec2e05e4515cd8809"
  );
  await Firebase.initializeApp(options: options);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Web Portal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // home: const HomeScreen(),
      home: FirebaseAuth.instance.currentUser==null ? const LoginScreen(): const HomeScreen(),
        // FirebaseAuth.instance.currentUser == null ? const LoginScreen() :
    );
  }
}


