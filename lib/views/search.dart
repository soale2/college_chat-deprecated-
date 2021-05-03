import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_chat/constants/colors.dart';
import 'package:college_chat/helper/constants.dart';
import 'package:college_chat/helper/helperfunctions.dart';
import 'package:college_chat/services/database.dart';
import 'package:college_chat/views/conversation_screen.dart';
import 'package:college_chat/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

String _myName;

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  QuerySnapshot searchSnapshot;


  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
        itemCount: searchSnapshot.docs.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
          return SearchTile(
            userName: searchSnapshot.docs[index].data()["name"],
            userEmail: searchSnapshot.docs[index].data()["email"],
          );
        }) : Container();
  }

  initiateSearch(){
    databaseMethods.getUserByUsername(searchTextEditingController.text).then((val){
      setState(() {
        searchSnapshot = val;
      });
    });
  }


  createChatroomAndStartConversation({String userName}){
    print("${Constants.myName}");
    if(userName != Constants.myName){
      String chatRoomId = getChatRoomId(userName, Constants.myName);

      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> charRoomMap = {
        "users" : users,
        "chatroomId" : chatRoomId,
      };

      DatabaseMethods().createChatRoom(chatRoomId, charRoomMap);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ConversationScreen(
        chatRoomId
      ),
      ),
      );
    }else{
      print("you cannot send message to yourself");
    }
  }

  Widget SearchTile({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName,
                style: TextStyle(
                  fontSize: 18,
                  color: STRONG_CYAN,
                ),
              ),
              Text(userEmail,
                style: TextStyle(
                  fontSize: 18,
                  color: STRONG_CYAN,
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatroomAndStartConversation(
                userName: userName
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: STRONG_CYAN,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16 ,vertical: 16 ),
              child: Text("Message", style: mediumTextStyle(),),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Search',
          style: TextStyle(
            color: WHITE,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: VERY_DARK_BLUE,
      ),
    body: Container(
      child: Column(
        children: [
          Container(
            color: DARK_GREYISH_BLUE,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      style: TextStyle(
                        color: STRONG_CYAN,
                      ),
                      decoration: InputDecoration(
                      hintText: "search username...",
                      hintStyle: TextStyle(
                        color: WHITE,
                      ),
                      border: InputBorder.none,
                    ),
                    ),
                ),
                GestureDetector(
                  onTap: (){
                    initiateSearch();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            VERY_DARK_BLUE,
                            DARK_GREYISH_BLUE
                          ]
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: EdgeInsets.all(12.0),
                      child: Image.asset("assets/images/search_white.png")),
                ),
              ],
            ),
          ),
          searchList()
        ],
      ),
    ),
    ),
    );
  }
}


getChatRoomId(String a, String b){
  if(a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)){
    return "$b\_$a";
  }else{
    return "$a\_$b";
  }
}

