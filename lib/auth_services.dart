import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInSignUpResult {
  final User user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}

class AuthServices{
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp({String email, String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      return SignInSignUpResult(user: result.user);
    } catch (error) {
      return SignInSignUpResult(message: error.toString());
    }
  }

  static Future<SignInSignUpResult> signIn({String email, String password}) async {
    try {

       UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
       
       return SignInSignUpResult(user: result.user);
    
    } catch (error) {
      return SignInSignUpResult(message: error.toString());
    }
  }

  static Future<void> signOut() async {
    _auth.signOut();

    return null; 
  }

  static Stream<User> get firebaseUserStream => _auth.authStateChanges(); 
}