import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_chat/model/message.dart';
import 'package:college_chat/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Reference _storageReference;

  OurUser _userFromFirebaseUser(User user){   //TODO:User is OurUser
    return user != null ? OurUser(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password); //TODO:AuthResult is now UserCredential
      User firebaseUser = result.user; //TODO:FirebaseUser is now User
      return _userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e.toString());
    }

  }

  Future signUpWithEmailAndPassword(String email, String password)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e.toString());
    }

  }

  Future resetPass(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }

  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){

    }
  }

  Future<String> uploadImageToStorage(File image) async{
    try{
      _storageReference = storage.ref().child('${DateTime.now().millisecondsSinceEpoch}');

      UploadTask _storageUploadTask = _storageReference.putFile(image);

      var url = await (await _storageUploadTask.then((res){
        res.ref.getDownloadURL();
      }));
      return url;
    }catch(e){
      print(e);
      return null;
    }
  }

  void setImageMsg(String url,String sendBy) async{
    Message _message;
    _message = Message.imageMessage(
      message: "IMAGE",
      sendBy: sendBy,
      photoUrl: url,
      timestamp: Timestamp.now(),
      type: 'image',
    );

    var map = _message.toImageMap();


  }

  void uploadImage(File image, String sendBy)async{
    String url = await uploadImageToStorage(image);

    setImageMsg(url,sendBy);
  }

}