import 'package:college_chat/constants/colors.dart';
import 'package:college_chat/helper/authenticate.dart';
import 'package:college_chat/helper/constants.dart';
import 'package:college_chat/helper/helperfunctions.dart';
import 'package:college_chat/services/auth.dart';
import 'package:college_chat/services/database.dart';
import 'package:college_chat/views/calendarScreen.dart';
import 'package:college_chat/views/conversation_screen.dart';
import 'package:college_chat/views/search.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();


  Stream chatRoomsStream;

  Widget chatRoomList(){
    return StreamBuilder(stream: chatRoomsStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context,index){
              return ChatRoomTile(
                  snapshot.data.docs[index].data()["chatroomId"].toString()
                      .replaceAll("_", "").replaceAll(Constants.myName, ""),
                  snapshot.data.docs[index].data()["chatroomId"]
              );
            }) : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }



  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNamePreference();
    databaseMethods.getChatRooms(Constants.myName).then((value){
      setState(() {
        chatRoomsStream = value;
      });
    });
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chats',
            style: TextStyle(
              color: WHITE,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => Authenticate(),
              ),
              );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.exit_to_app)),
            ),
          ],
          elevation: 0,
          backgroundColor: VERY_DARK_BLUE,
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


              ],
            ),
          ),
        ),
        body: chatRoomList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: STRONG_CYAN,
          child: Icon(Icons.search),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()
            )
            );
          },
        ),
    ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {

  final String userName;
  final String chatRoomId;
  ChatRoomTile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ConversationScreen(chatRoomId)));
      },
      child: Container(
        color: DARK_GREYISH_BLUE,
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: STRONG_CYAN,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text("${userName.substring(0,1).toUpperCase()}"),
            ),
            SizedBox(width: 8,),
            Text(userName,
              style: TextStyle(
                fontSize: 16,
                color: STRONG_CYAN,
              ),),
          ],
        ),
      ),
    );
  }
}

