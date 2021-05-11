import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_chat/constants/colors.dart';
import 'package:college_chat/helper/constants.dart';
import 'package:college_chat/services/database.dart';
import 'package:college_chat/utils/utilities.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'chatRoomsScreen.dart';


class ConversationScreen extends StatefulWidget {

  final String chatRoomId;
  ConversationScreen(this.chatRoomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  FirebaseStorage storage = FirebaseStorage.instance;
  TextEditingController messageController = new TextEditingController();
  Stream chatMessagesStream;
  final reference = FirebaseDatabase.instance.reference().child('messages');

  Widget ChatMessageList(){
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index){
              return MessageTile(snapshot.data.docs[index].data()["message"],
                  snapshot.data.docs[index].data()["sendBy"] == Constants.myName );
            }) : Container();
      },
    );
  }

  sendMessage(){

    if(messageController.text.isNotEmpty){
      Map<String,dynamic> messageMap ={
        "message" : messageController.text,
        "sendBy" : Constants.myName,
        "time" : DateTime.now().millisecondsSinceEpoch,
        "timeStamp":Timestamp.now(),
      };
      databaseMethods.addConversationMessages(widget.chatRoomId,messageMap);
      messageController.text = "";
    }
  }

  void _sendMessage({String messageText ,String imageUrl}){
    reference.push().set({
      'message':messageController.text,
      'imageUrl':imageUrl,
      'sendBy':Constants.myName
    });
  }

  // getImage({@required ImageSource source}) async{
  //   File selectedImage = await Utils.getImage(source:source);
  //   _repository.uploadImage(
  //     image:selectedImage,
  //     sendBy:Constants.myName,
  //   );
  // }

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessagesStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("College Notes",
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
        child: Stack(
          children: [
            ChatMessageList(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                height: 60,
                width: double.infinity,
                color: DARK_GREYISH_BLUE,
                child: Row(
                  children: [
                    Container(
                      margin: new EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.photo_camera,
                          color: STRONG_CYAN,
                        ),
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          String downloadUrl;
                          PickedFile pickedImage = await _picker.getImage(source: ImageSource.gallery);
                          File imageFile = File(pickedImage.path);
                          int timestamp = new DateTime.now().millisecondsSinceEpoch;
                          Reference storageReference = storage.ref().child("img_" + timestamp.toString() + ".jpg");
                          UploadTask uploadTask = storageReference.putFile(imageFile);
                          uploadTask.whenComplete(() async{
                            downloadUrl = await storageReference.getDownloadURL();
                          });
                          _sendMessage(messageText: null,imageUrl: downloadUrl.toString());
                        },
                      ),
                    ),
                    Expanded(child: TextField(
                      controller: messageController,
                      style: TextStyle(
                        color: STRONG_CYAN,
                      ),
                      decoration: InputDecoration(
                        hintText: "Write Message...",
                        hintStyle: TextStyle(
                          color: STRONG_CYAN,
                      ),
                        border: InputBorder.none
                ),
              ),
             ),
                    SizedBox(width: 15,),
                    FloatingActionButton(onPressed: (){
                      sendMessage();
                    },
                    child: Icon(Icons.send,color: DARK_GREYISH_BLUE,size: 18,),
                      backgroundColor: STRONG_CYAN,
                      elevation: 0,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 0 : 24, right: isSendByMe ? 24 : 0),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSendByMe ? [
              STRONG_CYAN,
              STRONG_CYAN,
            ] : [
              DARK_GREYISH_BLUE,
              DARK_GREYISH_BLUE
              ]
          ),
          borderRadius: isSendByMe ?
              BorderRadius.only(
                topLeft: Radius.circular(23),
                bottomLeft: Radius.circular(23),
                bottomRight: Radius.circular(23),
              ) :
          BorderRadius.only(
            topRight: Radius.circular(23),
            bottomLeft: Radius.circular(23),
            bottomRight: Radius.circular(23),
          )
        ),
        child: Text(message, style: TextStyle(
          fontSize: 16,
        color: WHITE,
        ),),
      ),
    );
  }
}
