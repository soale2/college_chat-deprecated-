import 'package:college_chat/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
}