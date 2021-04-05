import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditNote extends StatefulWidget {

  DocumentSnapshot docToEdit;
  EditNote({this.docToEdit});

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    
    title = TextEditingController(text: widget.docToEdit.data()['Title']);
    content = TextEditingController(text: widget.docToEdit.data()['Content']);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference notes = firestore.collection('notes');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        actions: [
          FlatButton(
            onPressed: (){

              widget.docToEdit.reference.delete().whenComplete(() => Navigator.pop(context));

              
            }, 
            child: Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
      
          ),

          FlatButton(
            onPressed: (){

              widget.docToEdit.reference.update({
                'Title': title.text,
                'Content': content.text
              }).whenComplete(() => Navigator.pop(context));

              
            }, 
            child: Text(
              'Update',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
      
          ),
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
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0)
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
                    contentPadding: EdgeInsets.all(16.0)
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