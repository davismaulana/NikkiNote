import 'package:flutter/material.dart';
import 'package:nikkinotes/components/rounded_button.dart';
import 'package:nikkinotes/login_screen.dart';
import 'background.dart';
import 'package:nikkinotes/signup_screen.dart';

class BodyNewUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text(
              "WELCOME",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset("assets/splashscreen.png"),
            RoundedButton(
              text: "LOGIN",
              press: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
             RoundedButton(
              text: "REGISTER",
              press: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                      return SignupScreen();
                    },
                  ),
                );
              },
            ),
          ],
    ),
      ),);
  }
}

class BodyUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text(
              "WELCOME",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset("assets/splashscreen.png"),
          ],
        ),
      ),);
  }
} 




