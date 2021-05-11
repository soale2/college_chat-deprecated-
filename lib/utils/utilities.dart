import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Im;
import 'dart:math';

final ImagePicker _picker = ImagePicker();

class Utils{
  static Future<File> getImage({@required ImageSource source}) async {
    PickedFile pickedImage = await _picker.getImage(source: ImageSource.camera);
    File selectedImage = File(pickedImage.path);
    return await compressImage(selectedImage);
  }

  static Future<File> compressImage(File imageToCompress) async {

    final tempDir = await getTemporaryDirectory();

    final path = tempDir.path;

    int random = Random().nextInt(1000);

    Im.Image image = Im.decodeImage(imageToCompress.readAsBytesSync());
    Im.copyResize(image, width: 500, height: 500);

    return new File('$path/img_$random.jpg')..writeAsBytesSync(Im.encodeJpg(image,quality: 85));
  }
}