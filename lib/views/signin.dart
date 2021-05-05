import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_chat/constants/colors.dart';
import 'package:college_chat/helper/helperfunctions.dart';
import 'package:college_chat/services/auth.dart';
import 'package:college_chat/services/database.dart';
import 'package:college_chat/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chatRoomsScreen.dart';

class SignIn extends StatefulWidget {

  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  QuerySnapshot snapshotUserInfo;

  signIn(){
    if(formKey.currentState.validate()){
      HelperFunctions.saveUserEmailPreference(emailTextEditingController.text);

      databaseMethods.getUserByUserEmail(emailTextEditingController.text)
          .then((val){
        snapshotUserInfo = val;
        HelperFunctions.saveUserNamePreference(snapshotUserInfo.docs[0].data()["name"]);
        //print("${snapshotUserInfo.docs[0].data()["name"]}");
      });

      setState(() {
        isLoading = true;
      });

      authMethods.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val){
        //print("${val.uid}");
        if(val != null){

          HelperFunctions.saveUserLoggedInPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => ChatRoom(),
          ),
          );
        }

      }); //setState
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('College Chat',
        style: TextStyle(
          color: WHITE,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        ),
        elevation: 0,
        backgroundColor: VERY_DARK_BLUE,
      ),
      body:isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                Hero(
                  tag: 'logo',
                  child: Padding(padding: EdgeInsets.all(35),
                    child: Image.asset("assets/images/circle-logo.png",height: 235,width: 235,),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (val){
                                  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val) ? null: "Please Provide a Valid Email";
                                },
                                controller: emailTextEditingController,
                                style: simpleTextStyle(),
                                decoration: textFieldInputDecoration("email"),
                              ),
                              TextFormField(
                                obscureText: true,
                                validator: (val){
                                  return val.length > 6 ? null : "The password must be greater than 6 characters";
                                },
                                controller: passwordTextEditingController,
                                style: simpleTextStyle(),
                                decoration: textFieldInputDecoration("password"),
                              ),
                              SizedBox(height: 8,),
                              Container(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    authMethods.resetPass(emailTextEditingController.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("password to reset email sent"),
                                      duration: Duration(seconds: 5),
                                      )
                                    );
                                  },
                                  child: Text("Forgot Password?", style: simpleTextStyle(),),
                                ),
                              ),
                              SizedBox(height: 8,),
                              ElevatedButton(onPressed:signIn,
                                style: ElevatedButton.styleFrom(
                                  primary: STRONG_CYAN,
                                  elevation: 5,
                                  shadowColor: DARK_GREYISH_BLUE,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                     ),
                                  padding: EdgeInsets.symmetric(horizontal:100, vertical:18),
                                ),
                                  child: Text("Sign In",style: mediumTextStyle(),
                                  ),
                              ),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have account?",style: TextStyle(fontSize: 18,color: WHITE),),
                                  TextButton(onPressed: (){
                                    widget.toggle();
                                  },
                                    child: Text("Register Now",style: TextStyle(fontSize: 18,color: Colors.greenAccent,decoration: TextDecoration.underline),),),
                                ],
                              ),
                              SizedBox(height: 30,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),

    ),
    );
  }
}
