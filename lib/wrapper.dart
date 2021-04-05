import 'package:flutter/material.dart';
import 'package:nikkinotes/Screens/Welcome/welcome_screen_new_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nikkinotes/homepage.dart';
import 'package:nikkinotes/login_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User firebaseUser = Provider.of<User>(context);
    return (firebaseUser == null) ? WelcomeScreenNewUser() : HomePage(user: firebaseUser);
  }
}