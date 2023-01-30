import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_base/common/theme/loading/loading.dart';

typedef ReturnImageUrl = ValueChanged<String>;

class TakePhotoController extends GetxController {
  TakePhotoController();

  Future<String> getImage({bool isTakePhoto = false}) async {
    try {
      final XFile? photo;
      if (isTakePhoto) {
        photo = await ImagePicker().pickImage(source: ImageSource.camera);
      } else {
        photo = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
        );
      }
      File imageFile = File(photo!.path);
      Uint8List imageRaw = await imageFile.readAsBytes();
      final imageEncoded = base64.encode(imageRaw);
      var result = uploadPhoto(imageEncoded);
      return result;
    } catch (e) {
      return "";
    }
  }

  Future<String> uploadPhoto(String imageEncoded) async =>
      await Loading.openAndDismissLoading<String>(
        () async {
          try {
            var dataImage;
            String data = "";
            // await ProductStore.to.upLoadPhoto(sourceBase64: imageEncoded).then(
            //       (value) => {
            //         dataImage = jsonDecode(value.toString()),
            //         if (dataImage['data']['url'] != null)
            //           {
            //             data = dataImage['data']['url']
            //           },
            //       },
            //     );
            return data;
          } catch (e) {
            return "";
          }
        },
      ) ??
      "";
}
