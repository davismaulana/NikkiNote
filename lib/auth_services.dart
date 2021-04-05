import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices{
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User> signInAnonymous() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User firebaseUser = result.user;

      return firebaseUser;

    } catch (e) {
      print(e.toString());

      return null;
    }
    
  }

  static Future<User> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser = result.user;

      return firebaseUser;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<User> signIn(String email, String password) async {
    try {

       UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
       User firebaseUser = result.user;
       
       return firebaseUser;
    
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> signOut() async {
    _auth.signOut();

    return null; 
  }

  static Stream<User> get firebaseUserStream => _auth.authStateChanges(); 
}