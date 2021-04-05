import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddNote extends StatelessWidget {

   final User user;
   AddNote(this.user);

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference notes = firestore.collection('notes');
    DateTime now = new DateTime.now();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        actions: [
          FlatButton(
            onPressed: (){
              notes.add({
                'IdUser': user.uid,
                'Title': title.text,
                'Content': content.text,
                'Day' : now.day.toString(),
                'Month' : now.month.toString(),
                'Year' : now.year.toString(),
                'Date' : now,
              }).whenComplete(() => Navigator.pop(context));
              
            }, 
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
      
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: 'Title',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),

            SizedBox(height: 10,),

            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: content,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    hintText: 'Content',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}