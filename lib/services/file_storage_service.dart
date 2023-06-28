import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class FileStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      await _storage.ref('test/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<ListResult> listFiles() async {
    ListResult results = await _storage.ref('test').listAll();
    results.items.forEach((element) {
      print('found file $element');
    });
    return results;
  }

  Future<String> downloadURL(String imageName) async {
    var url = await _storage.ref('test/$imageName').getDownloadURL();
    return url;
  }
}
