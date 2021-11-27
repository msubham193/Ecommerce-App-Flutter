// ignore_for_file: prefer_const_constructors


import 'package:ecommerceapp/screens/Signup.dart';
import 'package:ecommerceapp/screens/intro.dart';
import 'package:ecommerceapp/screens/otp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
      home:Intro(),
    );
  }
}
