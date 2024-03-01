// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final class UserModelUtils {
  UserModelUtils._();

  static Future<void> changeCurrentUserRole(UserRoles role) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"role": role.name});
  }
}

enum UserRoles {
  MANAGER,
  EMPLOYEE,
  ADMIN,
  UNKNOWN,
}

UserRoles getUserRoleFromString(String role) {
  switch (role.toUpperCase()) {
    case "MANAGER":
      return UserRoles.MANAGER;
    case "EMPLOYEE":
      return UserRoles.EMPLOYEE;
    case "ADMIN":
      return UserRoles.ADMIN;
    default:
      return UserRoles.UNKNOWN;
  }
}
