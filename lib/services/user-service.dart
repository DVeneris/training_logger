import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_tracker/DTOS/user-dto.dart';
import 'package:training_tracker/DTOS/user_profile_dto.dart';
import 'package:training_tracker/mappers/user-mapper.dart';
import 'package:training_tracker/models/user.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/snapshot_object.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(String? username) async {
    var authUser = AuthService().user;
    if (authUser == null) {
      return;
    }

    var data = authUser.providerData;
    UserInfo info;
    var usetToAdd = AppUser(
      uid: authUser.uid,
      email: authUser.email,
      userName: username != null
          ? username.toLowerCase()
          : authUser.uid.toLowerCase(),
      createdDate: DateTime.now(),
    );
    var userMap = usetToAdd.toMap();
    await _db.collection('user').doc(authUser.uid).set(userMap);
  }

  Future<void> updateUser(UserProfileDTO userData) async {
    var authUser = AuthService().user;
    if (authUser == null) {
      return;
    }

    var userMap = userData.toMap();
    await _db.collection('user').doc(authUser.uid).update(userMap);
  }

  Future<UserDTO> getCurrentUser() async {
    var authUser = AuthService().user;
    if (authUser == null) {
      throw Exception("null user");
    }
    return getUserByUid(authUser.uid);
  }

  Future<UserDTO> getUserByUid(String uid) async {
    var ref = _db.collection('user').doc(uid);
    var snapshot = await ref.get(); //read collection once
    return AppUser.fromJson(snapshot.data() ?? {}).toDTO();
  }

  Future<List<UserDTO>> getUsersByUsername(String username) async {
    var snapshot = await _db
        .collection('user')
        .where('userName', isEqualTo: username.toLowerCase())
        .get();

    Iterable<SnapshotObject> snapshotList = <SnapshotObject>[];
    snapshotList = snapshot.docs.map((s) {
      return SnapshotObject(id: s.id, data: s.data());
    });
    var users = snapshotList.map((e) => AppUser.fromJson(e.data));
    //  if (users.length ==null 1) {
    //     return null;
    //     // throw Exception("Too many users with this username");
    //   }
    var list = <UserDTO>[];
    for (var user in users) {
      list.add(user.toDTO());
    }
    return list;
  }
}
