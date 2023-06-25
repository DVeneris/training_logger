import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_tracker/DTOS/user-dto.dart';
import 'package:training_tracker/mappers/user-mapper.dart';
import 'package:training_tracker/models/user.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/snapshot_object.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(String username) async {
    var authUser = AuthService().user;
    if (authUser == null) {
      return;
    }

    var data = authUser.providerData;
    UserInfo info;
    var usetToAdd = AppUser(
      uid: authUser.uid,
      email: authUser.email,
      userName: username.toLowerCase(),
      createdDate: DateTime.now(),
    );
    // var ref = _db.collection('user');
    //var userMap = usetToAdd.toMap();
    //     var snapshot = await ref.add(userMap);
  }

  Future<UserDTO> getUserByUid(String uid) async {
    var ref = _db.collection('user').doc(uid);
    var snapshot = await ref.get(); //read collection once
    return AppUser.fromJson(snapshot.data() ?? {}).toDTO();
  }

  Future<UserDTO?> getUserByUsername(String username) async {
    var snapshot = await _db
        .collection('user')
        .where('username', isEqualTo: username)
        .get();

    Iterable<SnapshotObject> snapshotList = <SnapshotObject>[];
    snapshotList = snapshot.docs.map((s) {
      return SnapshotObject(id: s.id, data: s.data());
    });
    var users = snapshotList.map((e) => AppUser.fromJson(e.data));
    if (users.length != 1) {
      return null;
      // throw Exception("Too many users with this username");
    }
    return users.first.toDTO();
  }
}
