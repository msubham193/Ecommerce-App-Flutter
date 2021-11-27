// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:ecommerceapp/color/colorPallet.dart';
import 'package:ecommerceapp/widget/TextForm.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
    TextEditingController emailController =
      TextEditingController(); 
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

                       Lottie.asset('assets/forgot.json',width: 280.0,height:250.0,),
                       SizedBox(height: 60,),
                       Text('Forgot Password?',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.black87,letterSpacing: 1),),
                       SizedBox(height: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width -70,
                          child: Text('Please enter adress associated with your account!',textAlign:TextAlign.center,style: TextStyle(fontSize: 17.0,color: Colors.black87,letterSpacing: 1),)),
                        SizedBox(height: 40,),
                       TextForm(context,"Email",emailController, false),
                        SizedBox(height: 30,),
                       Button(),


                  ],),



        ),
      ),
    );
  }


   Widget Button() {
    var isStretched;
    return InkWell(
      onTap: () async {
        setState(() {
          isStretched = !isStretched;
        });
        await Future.delayed(Duration(milliseconds: 3000));
        setState(() {
          var isAnimation = true;
        });
        print(emailController.text);
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
