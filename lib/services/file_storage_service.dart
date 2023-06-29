import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:training_tracker/models/media_item.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:uuid/uuid.dart';

class FileStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = AuthService().user;

  Future<void> uploadFile(String filePath) async {
    if (_user == null) {
      return;
    }
    File file = File(filePath);
    const uuid = Uuid();
    var filename = uuid.v4();
    var url = await downloadURL(filename);
    if (url == null) return; //+throw error

    try {
      await _storage.ref('${_user?.uid}/$filename').putFile(file);
      var fileurl = await downloadURL(filename);

      MediaItem media =
          MediaItem(id: filename, userId: _user!.uid, name: filename, url: "");
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

  Future<String?> downloadURL(String imageName) async {
    if (_user == null) {
      return null;
    }
    try {
      var url = await _storage.ref('${_user?.uid}/$imageName').getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      return null;
      // if (e.code == 'storage/object-not-found'){}
      // TODO
    }
  }
}
