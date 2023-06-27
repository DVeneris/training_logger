import 'package:training_tracker/DTOS/user-dto.dart';
import 'package:training_tracker/models/user.dart';

extension ExerciseMapping on AppUser {
  UserDTO toDTO() {
    return UserDTO(
        uid: uid,
        email: email,
        userName: userName,
        createdDate: createdDate,
        identifier: identifier,
        provider: provider,
        signinDate: signinDate,
        description: description,
        link: description,
        name: name);
  }
}
