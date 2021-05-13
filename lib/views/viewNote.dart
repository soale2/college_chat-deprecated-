import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_chat/constants/colors.dart';
import 'package:college_chat/services/auth.dart';
import 'package:college_chat/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {

  final Map data;
  final String time;
  final DocumentReference ref;

  ViewNote(this.data, this.time, this.ref);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {

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
                      ElevatedButton(onPressed: delete,
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32)
                                  )
                              ),
                              backgroundColor: MaterialStateProperty.all(Colors.red),
                              padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0,
                              )
                              )
                          ),

                          child: Icon(Icons.delete)
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.data['title']}",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: STRONG_CYAN,
                          ),
                        ),
                        //
                        Padding(
                          padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                          child: Text(
                            widget.time,
                            style: TextStyle(
                              fontSize: 20,

                              color: Colors.greenAccent,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          height: MediaQuery.of(context).size.height * 0.75,
                          padding: const EdgeInsets.only(top:12.0),
                          child: Text(
                            "${widget.data['description']}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: WHITE,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
  void delete() async{ //delete to db
    await widget.ref.delete();
    Navigator.pop(context);
  }
}
