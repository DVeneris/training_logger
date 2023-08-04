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
  final AuthService _authService = AuthService();

  Future<UserDTO?> createUser(String? username) async {
    var authUser = _authService.getUser();
    if (authUser == null) {
      return null;
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
      signinDate: DateTime.now(),
    );
    var userMap = usetToAdd.toMap();
    await _db.collection('user').doc(authUser.uid).set(userMap);
    return UserDTO(
        uid: usetToAdd.uid,
        email: usetToAdd.email,
        userName: usetToAdd.userName,
        createdDate: usetToAdd.createdDate,
        signinDate: usetToAdd.signinDate);
  }

  Future<void> updateUser(UserProfileDTO userData) async {
    var authUser = _authService.getUser();
    if (authUser == null) {
      return;
    }

    var userMap = userData.toMap();
    await _db.collection('user').doc(authUser.uid).update(userMap);
  }

  Future<UserDTO> getCurrentUser() async {
    var authUser = _authService.getUser();
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
    var ref = _db.collection('user');

    var snapshot =
        await ref.where('userName', isEqualTo: username.toLowerCase()).get();

    Iterable<SnapshotObject> snapshotList = <SnapshotObject>[];
    snapshotList = snapshot.docs.map((s) {
      return SnapshotObject(id: s.id, data: s.data());
    });
    var users = snapshotList.map((e) => AppUser.fromJson(e.data));
    var list = <UserDTO>[];
    for (var user in users) {
      list.add(user.toDTO());
    }
    return list;
  }

  Future<UserDTO?> checkIfUserExistsandCreateUser(username) async {
    var users = await getUsersByUsername(username);
    if (users.isEmpty) {
      //await updateUser(UserProfileDTO(userName: username));
      var user = await createUser(username);
      return user;
    }
    return null;
  }

  Future<bool> checkIfUserExists(username) async {
    var users = await getUsersByUsername(username);
    if (users.isEmpty) {
      return false;
    }
    return true;
  }
}
