import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:training_tracker/DTOS/media-item-dto.dart';
import 'package:training_tracker/models/media_item.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class FileStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  Future<MediaItemDTO?> uploadFile(File file) async {
    var authUser = _authService.getUser();
    if (authUser == null) {
      return null;
    }
    const uuid = Uuid();
    var filename = uuid.v4();
    try {
      final fileExtension = p.extension(file.path);
      Map<String, String> metadata = {"extension": fileExtension};
      await _storage.ref('${authUser.uid}/$filename').putFile(
          file,
          SettableMetadata(
            customMetadata: metadata,
          ));

      var fileurl = await getURL(filename);
      if (fileurl != null) {
        await downloadFile("$filename$fileExtension", fileurl);
      }

      MediaItemDTO mediaItem = MediaItemDTO(
          id: filename, userId: authUser.uid, name: filename, url: fileurl);
      return mediaItem;
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
    return null;
  }

  Future<ListResult> listFiles() async {
    ListResult results = await _storage.ref('test').listAll();
    results.items.forEach((element) {
      print('found file $element');
    });
    return results;
  }

  Future<String?> getURL(String imageName) async {
    var authUser = _authService.getUser();
    if (authUser == null) {
      return null;
    }
    try {
      var url =
          await _storage.ref('${authUser.uid}/$imageName').getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Future<void> downloadFile(String fileName, String url) async {
    var authUser = _authService.getUser();
    if (authUser == null) {
      return;
    }
    try {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final filePath = "${appDocDir.path}/${authUser.uid}/$fileName";
      final file = await File(filePath).create(recursive: true);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
      }
    } on FirebaseException catch (e) {
      return;
    }
  }
}
