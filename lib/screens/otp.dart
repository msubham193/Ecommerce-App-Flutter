// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore, non_constant_identifier_names, sized_box_for_whitespace, unused_local_variable, unnecessary_new, avoid_print

import 'package:ecommerceapp/screens/Signup.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ecommerceapp/color/colorPallet.dart';
import 'package:ecommerceapp/widget/TextForm.dart';

import 'Home.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static var currentUser = FirebaseAuth.instance.currentUser!.email;
  TextEditingController otpController = TextEditingController();
  bool isStretched = false;
  bool isAnimation = false;
  bool isValidate = false;

  SignUp signUp = SignUp();
  EmailAuth emailAuth = EmailAuth(sessionName: 'Ecommerce App');
  void sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: currentUser.toString(), otpLength: 5);

    if (!result) {
      print("Not able to sent");
    } else {
      print("sent");
    }
  }

  void verifyOtp() async {
    var res = emailAuth.validateOtp(
        recipientMail: currentUser.toString(),
        userOtp: otpController.value.text);
    if (res) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    } else {
      final snackbar = SnackBar(content: Text("Invalid otp!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      try {
        await FirebaseAuth.instance.currentUser!.delete();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/otp.json',
                width: 280.0,
                height: 250.0,
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                'Otp Verification!',
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 1),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: MediaQuery.of(context).size.width - 70,
                  child: Text(
                    'Please enter one time password sent to ' +
                        currentUser.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                        letterSpacing: 1),
                  )),
              SizedBox(
                height: 40,
              ),
              TextForm(context, "Enter otp", otpController, false),
              SizedBox(
                height: 30,
              ),
              Button(),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  sendOtp();
                },
                child: isValidate == true
                    ? Text(
                        "Resend otp",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      )
                    : Text(
                        "Resend otp",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
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
          isValidate = true;
        });

        await Future.delayed(Duration(milliseconds: 3000));
        verifyOtp();
        setState(() {
          isStretched = false;
          
        });
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
                    fontSize: 18,
                  )),
        ),
      ),
    );
  }
}
