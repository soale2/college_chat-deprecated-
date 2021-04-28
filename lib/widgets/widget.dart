import 'package:college_chat/constants/colors.dart';
import 'package:flutter/material.dart';

InputDecoration textFieldInputDecoration(String hintText){
return InputDecoration(
  hintText: hintText,
  hintStyle: TextStyle(
    color: STRONG_CYAN,
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: STRONG_CYAN),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: STRONG_CYAN),
  ),
);
}

TextStyle simpleTextStyle(){
  return TextStyle(
  color: STRONG_CYAN,
    fontSize: 16
  );
}

TextStyle mediumTextStyle(){
  return TextStyle(
      color: VERY_DARK_BLUE,
      fontSize: 20);
}