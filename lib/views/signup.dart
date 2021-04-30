import 'package:college_chat/constants/colors.dart';
import 'package:college_chat/helper/helperfunctions.dart';
import 'package:college_chat/services/auth.dart';
import 'package:college_chat/services/database.dart';
import 'package:college_chat/views/chatRoomsScreen.dart';
import 'package:college_chat/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  signMeUp(){
    if(formKey.currentState.validate()){
      Map<String, String> userInfoMap = {
        "name" : userNameTextEditingController.text,
        "email": emailTextEditingController.text
      };

      HelperFunctions.saveUserEmailPreference(emailTextEditingController.text);
      HelperFunctions.saveUserEmailPreference(userNameTextEditingController.text);

      setState(() {
        isLoading = true;
      });
      authMethods.signUpWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val){
        //print("${val.uid}");

        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInPreference(true);
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => ChatRoom()
        ),
        );

      }); //setState
    }
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
      Scaffold(
        appBar: AppBar(
          title: Text('Sign Up',
          style: TextStyle(
            color: WHITE,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
          elevation: 0,
         backgroundColor: VERY_DARK_BLUE,
      ),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : Row(
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
                      Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (val){
                                  return val.isEmpty || val.length < 3 ? "Please Provide a Valid Username" : null;
                                },
                                controller: userNameTextEditingController,
                                style: simpleTextStyle(),
                                decoration: textFieldInputDecoration("username"),
                              ),
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            authMethods.resetPass(emailTextEditingController.text);
                          },
                          child: Text("Forgot Password?", style: simpleTextStyle(),),
                        ),
                      ),
                      SizedBox(height: 8,),
                      ElevatedButton(onPressed: signMeUp,

                        style: ElevatedButton.styleFrom(
                          primary: STRONG_CYAN,
                          elevation: 5,
                          shadowColor: DARK_GREYISH_BLUE,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal:100, vertical:18),
                        ),
                        child: Text("Sign Up",style: mediumTextStyle(),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have account?",style: TextStyle(fontSize: 18,color: WHITE),),
                          TextButton(onPressed: (){
                            widget.toggle();
                          }, child: Text("Login Now",style: TextStyle(fontSize: 18,color: Colors.greenAccent,decoration: TextDecoration.underline),),),
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
