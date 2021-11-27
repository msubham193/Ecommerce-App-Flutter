// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore, import_of_legacy_library_into_null_safe, unnecessary_new, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/color/colorPallet.dart';
import 'package:ecommerceapp/screens/Login.dart';
import 'package:ecommerceapp/widget/TextForm.dart';

import 'otp.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isStretched = false;
  bool isAnimation = false;
  bool isSignUp = false;
  firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
  TextEditingController emailController =
      TextEditingController(); ////For get email and pasword from text input
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  late EmailAuth emailAuth;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  Future<void> addName() {
    return collectionReference
        .doc(emailController.text)
        .set({
          'name': nameController.text,
          'email': emailController.text,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void sendOtp() async {
    emailAuth = new EmailAuth(
      sessionName: "Ecommerce app",
    );
    bool result = await emailAuth.sendOtp(
        recipientMail: emailController.text, otpLength: 5);
    if (result) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create Account",
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
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
              SizedBox(height: 40),
              TextForm(context, "Name", nameController, false),
              SizedBox(height: 20),
              TextForm(context, "Email", emailController, false),
              SizedBox(height: 20),
              TextForm(context, "Password", passwordController, true),
              SizedBox(height: 40),
              Button(),
              SizedBox(height: 60),
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
                  ButtonChip('assets/google.svg', 25),
                  SizedBox(width: 50),
                  ButtonChip('assets/phone.svg', 30),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Are you member",
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
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "Sign in now",
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
    );
  }

  Widget Button() {
    return InkWell(
      onTap: () async {
        setState(() {
          isStretched = true;
        });

       
        try {
          firebase_auth.UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);
          sendOtp();
          try {
            addName();
          } catch (e) {
            final snackbar = SnackBar(content: Text(e.toString()));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }

          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return OtpScreen();
          }), );
        } catch (e) {
           await Future.delayed(Duration(milliseconds: 3000));
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);

          setState(() {
            isStretched = false;
          });
        }

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OtpScreen()));
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
            // Color(0xFFE1372D),
          ]),
        ),

        // ignore: prefer_const_constructors
        child: Center(
          child: isStretched == true
              ? CircularProgressIndicator()
              : Text("Continue",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: 18,
                  )),
        ),
      ),
    );
  }

  Widget ButtonChip(String imgPath, double size) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Palette.backgroundColor,
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: Center(
        child: SvgPicture.asset(
          imgPath,
          height: size,
          width: size,
        ),
      ),
    );
  }
}
