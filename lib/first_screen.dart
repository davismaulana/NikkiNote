import 'package:flutter/material.dart';
import 'package:nikkinotes/Screens/Welcome/welcome_screen_new_user.dart';
import 'package:nikkinotes/addNote.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikkinotes/auth_services.dart';
import 'package:nikkinotes/editNote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'background_time.dart';

import 'homepage.dart';

class FirstScreen extends StatelessWidget {

  final User user;  
  
  final ref = FirebaseFirestore.instance.collection('notes');

  final title;
  FirstScreen({this.title, this.user});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "Welcome",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          elevation: 10,
          backgroundColor: Colors.redAccent,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                color: Colors.redAccent,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                  child: ListTile(
                    title: Text(
                      '${user.email}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
              ),

              ListTile(
                leading: Icon(Icons.notes),
                title: Text('My Notes'),
                onTap: () {
                  User firebaseUser = Provider.of<User>(context, listen: false);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(user: firebaseUser),
                    )
                  );
                },
              ),
              Divider(
                height: 10.0,
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () async {
                  await AuthServices.signOut();
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreenNewUser()));
                },
              )
            ],
          ),
        ),
        body: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  child: Text(
                    'My Notes',
                  ),
                  onPressed: () {
                    User firebaseUser = Provider.of<User>(context, listen: false);
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage(user: firebaseUser)));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),   
                  ),
                ),
              ],
            ),
          ),
        ),
      
    );
  }
}


