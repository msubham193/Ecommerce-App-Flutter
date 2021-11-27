// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, duplicate_ignore

import 'package:ecommerceapp/color/colorPallet.dart';
import 'package:ecommerceapp/widget/TextForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:lottie/lottie.dart';

import 'Home.dart';
import 'Signup.dart';
import 'forgot.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isStretched = false;
  bool isAnimation = false;
  bool isMale = true;
  bool isSignUp = false;
  bool isRemember = false;
  firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
  TextEditingController emailController =
      TextEditingController(); ////For get email and pasword from text input
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Palette.backgroundColor,
      ),
      child: isAnimation
          ? Lottie.asset('assets/welldone.json',
              fit: BoxFit.contain, repeat: true)
          : Scaffold(
              backgroundColor: Palette.backgroundColor,
              body: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hello Again !",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width - 70,
                        child: Text(
                          "Wellcome back you've been missed!",
                          textAlign: TextAlign.center,

                          style: TextStyle(fontSize: 18, color: Colors.black87,letterSpacing: 1),
                        ),
                      ),
                      SizedBox(height: 40),
                      TextForm(context, "Email", emailController, false),
                      SizedBox(height: 20),
                      TextForm(context, "Password", passwordController, true),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                             
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPage()));

                            },
                            child: Text(
                              "Recover Password",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,letterSpacing: 1),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(width: 40)
                        ],
                      ),
                      SizedBox(height: 40),
                      Button(),
                      SizedBox(height: 80),
                      Text(
                        "----- Or continue with -----",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                            letterSpacing: 1,
                            fontSize: 15),
                      ),
                       SizedBox(height: 40),
                       Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           ButtonChip('assets/google.svg',25),
                           SizedBox(width: 50),
                           ButtonChip('assets/phone.svg',30),
                         ],
                       ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Not a member",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  letterSpacing: 1.5,
                                  fontSize: 15),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignUp = true;
                                });
                              },
                              child: InkWell(
                                onTap:(){
                                     
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                                },
                                child: Text(
                                  "Register now",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),

                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget Button() {
    return InkWell(
      onTap: () async {
        setState(() {
          isStretched = !isStretched;
        });

      try {
  firebase_auth.UserCredential userCredential = await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailController.text,
    password: passwordController.text,
  );
} on firebase_auth.FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}



        await Future.delayed(Duration(milliseconds: 2000));
        setState(() {
          isAnimation = true;
        });
        await Future.delayed(Duration(milliseconds: 2000));
         Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
         
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: 55,
        decoration: BoxDecoration(
          // ignore: prefer_const_literals_to_create_immutables
          borderRadius: BorderRadius.circular(15),
          // ignore: prefer_const_constructors
          gradient: LinearGradient(colors: [
             Color(0xFFE1372D),
            Color(0xFFFF5403),
          ]),
        ),

        // ignore: prefer_const_constructors
        child: Center(
          child: isStretched == true
              ? CircularProgressIndicator()
              : Text("Sign in",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                    fontSize: 18,
                  )),
        ),
      ),
    );
  }

  Widget ButtonChip(String imgPath,double size) {
    return Container(
      height:60,
      width:60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Palette.backgroundColor,
        border: Border.all(color: Colors.white, width: 3),
      ),
    
       child:Center(

       child: SvgPicture.asset(
                imgPath,
                height: size,
                width: size,
              ),


       ),

    );
  }
}
