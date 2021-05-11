import 'dart:io';

import 'package:college_chat/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';


class FirebaseRepository{
  AuthMethods authMethods = AuthMethods();

  void uploadImage({
  @required File image,
  @required String sendBy,
}) => authMethods.uploadImage(image,sendBy);
}