import 'package:flutter/material.dart';
import 'package:nikkinotes/Screens/Welcome/welcome_screen_new_user.dart';
import 'package:nikkinotes/addNote.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikkinotes/auth_services.dart';
import 'package:nikkinotes/editNote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  final User user;  
  
  final ref = FirebaseFirestore.instance.collection('notes');

  final title;
  HomePage({this.title, this.user});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            user.uid,
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold
            ),
          ),

          actions: [
            RaisedButton(
              child: Text("Sign Out"),
              onPressed: () async {
                await AuthServices.signOut();
                Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => WelcomeScreenNewUser()));
              },
            )
          ],

          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: Icon(
            Icons.add),
          onPressed: (){
            User firebaseUser = Provider.of<User>(context, listen: false);
            Navigator.push(context, MaterialPageRoute(builder: (_)=>AddNote(firebaseUser)));
          },  
        ),
        body: StreamBuilder(
          stream: ref.orderBy('Date').where("IdUser", isEqualTo: user.uid).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: snapshot.hasData?snapshot.data.docs.length:0,
            itemBuilder: (_,index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>EditNote(docToEdit: snapshot.data.docs[index],)));
                },
                child: Card(   
                  margin: EdgeInsets.all(10),
                  color: Colors.redAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        Text(
                          "${snapshot.data.docs[index].data()['Title']}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          snapshot.data.docs[index].data()['Content'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign:TextAlign.start,
                          
                        ),
                        SizedBox(height: 15,),
                        Text(
                          "${snapshot.data.docs[index].data()['Day']}-${snapshot.data.docs[index].data()['Month']}-${snapshot.data.docs[index].data()['Year']}",
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.end,
                          
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
          },
        ),
    );
  }
}


