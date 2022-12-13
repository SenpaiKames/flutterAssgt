import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobdev_app/routes.dart';
import 'package:mobdev_app/screens/Dashboard.dart';
import 'package:mobdev_app/screens/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.brown,
      scaffoldBackgroundColor: Color.fromARGB(255, 66, 133, 91),
      textTheme: 
        TextTheme (
          displaySmall: TextStyle(color: Colors.white),    
        ),
        inputDecorationTheme: const InputDecorationTheme(
        filled: true, 
        fillColor: Colors.white,  
        ), 
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: LoginScreen.routeName,
    routes: routes,
  ));
  
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  
  // FirebaseAuth.instance
  // .authStateChanges()
  // .listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });
  // FirebaseAuth.instance
  // .idTokenChanges()
  // .listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });

  }



