// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show ValueNotifier;

import 'document_service.dart';
import 'models/user_model/user_model.dart';

class UserModelService {
  final serviceNode = ValueNotifier<DocumentService<UserModel>?>(null);

  Future<void> createService({required String userId}) async {
    serviceNode.value = await DocumentService.create<UserModel>(
        FirebaseFirestore.instance.collection("users").doc(userId).withConverter<UserModel>(
              fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
              toFirestore: (model, _) => model.toJson(),
            ));
    serviceNode.notifyListeners();
    serviceNode.value?.listen();
  }

  void stopService() async {
    serviceNode.value?.cancel();
  }
}
