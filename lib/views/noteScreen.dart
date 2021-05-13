import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_chat/constants/colors.dart';
import 'package:college_chat/views/addNote.dart';
import 'package:college_chat/views/viewNote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'calendarScreen.dart';
import 'chatRoomsScreen.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key key}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {

  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child : Scaffold(
        appBar: AppBar(
          title: Text("Notes",style: TextStyle(
            color: WHITE,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          ),
          backgroundColor: VERY_DARK_BLUE,
          elevation: 0,
        ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNote()
              ),
              ).then((value){
                print("Calling setState");
                setState(() {
                  
                });
              });
            },
            child: Icon(
              Icons.add,
              color: VERY_DARK_BLUE,
            ),
            backgroundColor: STRONG_CYAN,
          ),
          drawer: Drawer(
            child: Container(
              decoration: BoxDecoration(
                color: DARK_GREYISH_BLUE,
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(child: Image.asset("assets/images/circle-logo.png",height: 235,width: 235,),
                    decoration: BoxDecoration(
                        color: VERY_DARK_BLUE
                    ),
                  ),
                  ListTile(
                    title: Text('Conversations',style: TextStyle(fontSize: 16,color: WHITE),),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => ChatRoom()));
                    },
                  ),
                  ListTile(
                    title: Text('Timetable',style: TextStyle(fontSize: 16,color: WHITE),),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => CalenderScreen()));
                    },
                  ),
                  ListTile(
                    title: Text('Notes',style: TextStyle(fontSize: 16,color: WHITE),),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => NoteScreen()));
                    },
                  ),


                ],
              ),
            ),
          ),
          body:  FutureBuilder<QuerySnapshot>(
            future: ref.get(),

            builder: (context,snapshot){
              if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index){
                    Map data = snapshot.data.docs[index].data();
                    DateTime mydateTime = data['created'].toDate();
                    String formattedTime = DateFormat.yMMMd().add_jm().format(mydateTime);
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: InkWell(
                       onTap: (){
                         Navigator.of(context).push(MaterialPageRoute(
                             builder: (context) => ViewNote(data , formattedTime ,
                                 snapshot
                                 .data
                                 .docs[index]
                                 .reference)
                         )
                         ).then((value){
                           setState(() {

                           });
                         });
                       },
                       child: Card(
                         color: DARK_GREYISH_BLUE,
                         child: Padding(
                           padding: const EdgeInsets.all(25.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                              Text("${data['title']}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: STRONG_CYAN,
                                ),

                              ),

                               Container(
                                 alignment: Alignment.centerRight,
                                 child: Text(
                                   formattedTime,
                                   style: TextStyle(
                                     fontSize: 12,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.greenAccent,
                                   )
                                 ),
                               )
                             ],
                           ),
                         ),
                       ),
                     ),
                   );
                  },
              );
              }else{
                return Center(child: Text("Loading"),
                );
              }
            },
          ),
        )
    );
  }
}
