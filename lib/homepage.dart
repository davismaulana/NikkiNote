import 'package:flutter/material.dart';
import 'package:nikkinotes/Screens/Welcome/welcome_screen_new_user.dart';
import 'package:nikkinotes/addNote.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nikkinotes/auth_services.dart';
import 'package:nikkinotes/editNote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nikkinotes/first_screen.dart';
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
          title: Text(
            "My Notes",
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
                    onTap: () {
                      User firebaseUser = Provider.of<User>(context, listen: false);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FirstScreen(user: firebaseUser),
                        )
                      );
                    },
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


