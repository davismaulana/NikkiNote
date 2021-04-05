import 'package:flutter/material.dart';
import 'package:nikkinotes/Screens/Welcome/welcome_screen_new_user.dart';
import 'package:nikkinotes/auth_services.dart';
import 'wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    
    home: MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.firebaseUserStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nikki Note',
        home: Wrapper(),
      ),
    );
  }
}
