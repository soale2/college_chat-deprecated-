import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String sendBy;
  String type;
  String message;
  Timestamp timestamp;
  String photoUrl;


  Message({
    this.sendBy,
    this.type,
    this.message,
    this.timestamp,
    this.photoUrl
  });

  Message.imageMessage({
    this.sendBy,
    this.type,
    this.message,
    this.timestamp,
    this.photoUrl,
  });

  Map toMap() {
    var map = Map<String,dynamic>();
    map['sendBy'] = this.sendBy;
    map['type'] = this.type;
    map['message'] = this.message;
    map['timestamp'] = this.timestamp;
    return map;
  }

  Map toImageMap() {
    var map = Map<String,dynamic>();
    map['sendBy'] = this.sendBy;
    map['type'] = this.type;
    map['message'] = this.message;
    map['timestamp'] = this.timestamp;
    map['photoUrl'] = this.photoUrl;
    return map;
  }

}