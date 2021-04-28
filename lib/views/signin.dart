import 'package:college_chat/constants/colors.dart';
import 'package:college_chat/services/auth.dart';
import 'package:college_chat/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  AuthMethods authMethods = new AuthMethods();

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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                Padding(padding: EdgeInsets.all(30),
                  child: Image.asset("assets/images/circle-logo.png",height: 235,width: 235,),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: Column(
                    children: [
                      TextField(
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("email"),
                      ),
                      TextField(
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("password"),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: (

                              ) {
                          },
                          child: Text("Forgot Password?", style: simpleTextStyle(),),
                        ),
                      ),
                      SizedBox(height: 8,),
                      ElevatedButton(onPressed: (){},
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
