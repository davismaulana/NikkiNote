import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nikkinotes/auth_services.dart';
import 'package:nikkinotes/first_screen.dart';
import 'package:nikkinotes/homepage.dart';
import 'auth_services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String email;
  String password;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red[300],
                  Colors.redAccent,
                ]
              )
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  autovalidate: true,
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[

                        // EMAIL

                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Please input your Email"),
                            EmailValidator(
                                errorText: "Email is invalid"),
                          ]),
                          onChanged: (value) {
                              email = value;
                          },
                          
                        ),

                        // PASSWORD

                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Please input your Password"),
                            MinLengthValidator(8, errorText: "Password must be at least 8 characters long"),
                          ]),

                          onChanged: (value) {
                              password = value;
                          },
            
                        ),
                        SizedBox(height: 30,),
                        RaisedButton(
                          color: Colors.redAccent,
                          textColor: Colors.white,
                          child: Text(
                            'Login',
                          ),
                          onPressed: (){
                            login();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),   
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            Text("Don't you have an account ? "),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context){
                                      return SignupScreen();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.redAccent,
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
            ),
          )
        ],
      ),
    );
  }
  void login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      SignInSignUpResult result = await AuthServices.signIn(email: email, password: password);
      if (result.user != null) {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => FirstScreen(user: result.user,))
        );
      }
      else if(result.message != null){
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
          )
        );
      }
    }
  }
}