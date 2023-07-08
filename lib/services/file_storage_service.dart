import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:training_tracker/models/media_item.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:uuid/uuid.dart';

class FileStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = AuthService().user;

  Future<MediaItem?> uploadFile(String filePath) async {
    if (_user == null) {
      return null;
    }
    File file = File(filePath);
    const uuid = Uuid();
    var filename = uuid.v4();
    try {
      // await testCompressAndGetFile(file, filename, _user!.uid);
      // File compressedFile = File("assets/${_user!.uid}/$filename");
      // if (compressedFile == null) return null;
      await _storage.ref('${_user?.uid}/$filename').putFile(file);
      var fileurl = await downloadURL(filename);

      MediaItem mediaItem = MediaItem(
          id: filename, userId: _user!.uid, name: filename, url: fileurl);
      return mediaItem;
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> testCompressAndGetFile(
      File file, String fileName, String userId) async {
    var filesplit = file.absolute.path.split('/');
    var _fileName = filesplit.last.split('.');
    // var result = await FlutterImageCompress.compressAssetImage(
    //   fileName,
    //   minHeight: 640,
    //   minWidth: 480,
    //   quality: 25,
    // );
    final filePath = file.absolute.path;
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      "assets/$userId/$fileName.${_fileName.last}",
      quality: 25,
    );
    if (result == null) return null;
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
