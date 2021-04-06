import 'package:flutter/material.dart';
import 'package:nikkinotes/auth_services.dart';
import 'package:nikkinotes/first_screen.dart';
import 'package:nikkinotes/homepage.dart';
import 'package:nikkinotes/login_screen.dart';
import 'auth_services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  String email;
  String password;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthServices _auth = AuthServices();

  TextEditingController _passwordController = new TextEditingController();  

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
                          validator: (value){
                            if (value.isEmpty) {
                              return 'Please input your Email';
                            }if (!value.contains('@')) {
                              return 'Invalid Email';
                            }
                            return null;
                          },
                          onChanged: (value) {
                              email = value;
                          },
                        ),

                        // PASSWORD

                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          controller: _passwordController,
                          validator: MultiValidator([
                            RequiredValidator(
                              errorText: "Please input your Password"),
                            MinLengthValidator(8,
                              errorText: "Minimum 8 Characters Required.")
                          ]),
                          onChanged: (value) {
                            password = value;
                          },
                        ),

                        // CONFIRM PASSWORD

                        TextFormField(
                          decoration: InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: (value){
                            if (value.isEmpty || value != _passwordController.text) {
                              return 'Password not validate';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            password = value;
                          },
                        ),

                        // BUTTON

                        SizedBox(height: 30,),
                        RaisedButton(
                          color: Colors.redAccent,
                          textColor: Colors.white,
                          child: Text(
                            'Submit',
                          ),
                          onPressed: () {
                            submit();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),   
                          ),
                        ),

                        // INFO
                        
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            Text("Do you have an account ? "),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context){
                                      return LoginScreen();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "Sign In",
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
  
  void submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      SignInSignUpResult result = await AuthServices.signUp(email: email, password: password);
      if (result.user != null) {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => FirstScreen(user: result.user,))
        );
      }else{
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: Text("ERROR"),
            content: Text(result.message),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                child: Text("OK"),
              )
            ],
          )
        );
      }
    }
  }
}