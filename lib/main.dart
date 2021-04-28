import 'package:college_chat/constants/colors.dart';
import 'package:college_chat/helper/authenticate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(34, 40, 49, 2),
      statusBarIconBrightness: Brightness.light));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: VERY_DARK_BLUE,
      ),
      title: 'Flutter',
      home: Authenticate(),
    );
  }
}