import 'dart:convert';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:image/image.dart' as image_lib;

import '../helper/constants.dart';

class ImageService {
  Future<String> getImagePathFromFireStorage(String imageUrl) async {
    if (imageUrl.isEmpty) {
      return '';
    }

    final firebaseStorage = FirebaseStorage.instanceFor(bucket: 'gs://test-1d90e.appspot.com').ref('public');

    final imageRef = firebaseStorage.child(imageUrl);

    return await imageRef.getDownloadURL();
  }

  Future<Uint8List> resizeAndEncodeImage(XFile file) async {
    final bytes = await file.readAsBytes();
    image_lib.Image image = image_lib.decodeImage(bytes)!;
    //size image to 120
    image_lib.Image resizedImage = image_lib.copyResize(image, width: 300);

    return image_lib.encodeJpg(resizedImage);
  }

  Future<String> uploadImage(XFile file) async {
    final resizedImageBytes = await compute(resizeAndEncodeImage, file);

    var request = MultipartRequest('POST', Uri.parse('${Constants.apiHostName}/Media/Upload'));
    request.files.add(
      MultipartFile.fromBytes('Media', resizedImageBytes, filename: file.name),
    );

    var response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return '${Constants.apiHostName}/${jsonDecode(body)['mediaUrl']}';
    }

    throw Exception('Failed to upload image CODE: ${response.statusCode} REASON: $body');
  }
}
