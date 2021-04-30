import 'package:college_chat/constants/colors.dart';
import 'package:college_chat/helper/authenticate.dart';
import 'package:college_chat/helper/constants.dart';
import 'package:college_chat/helper/helperfunctions.dart';
import 'package:college_chat/services/auth.dart';
import 'package:college_chat/views/search.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = new AuthMethods();

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNamePreference();
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
        floatingActionButton: FloatingActionButton(
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
