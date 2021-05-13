import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_chat/constants/colors.dart';
import 'package:college_chat/services/auth.dart';
import 'package:college_chat/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  String title;
  String des;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

          body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: BackButton(

                        color: STRONG_CYAN,

                      ),
                    ),
                    ElevatedButton(onPressed: add,

                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)
                            )
                          ),
                          backgroundColor: MaterialStateProperty.all(STRONG_CYAN),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0,
                          )
                          )
                        ),

                        child: Icon(Icons.save)
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Form(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration.collapsed(hintText: "Title",hintStyle: TextStyle(color: STRONG_CYAN)
                        ),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: STRONG_CYAN,
                        ),
                        onChanged: (_val){
                          title = _val;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        padding: const EdgeInsets.only(top:12.0),
                        child: TextFormField(
                          decoration: InputDecoration.collapsed(hintText: "Write Something...",
                              hintStyle: TextStyle(color: WHITE)
                          ),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: WHITE,
                          ),
                          onChanged: (_val){
                            des = _val;
                          },
                          maxLines: 25,
                        ),
                      )
                    ],
                  ),
                ),)
              ],
            ),
          ),
    ),
        )
    );
  }

  void add() async{ //save to db
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('notes');

    var data = {
      'title' : title,
      'description': des,
      'created': DateTime.now(),
    };

    ref.add(data);


    Navigator.pop(context);
  }
}
