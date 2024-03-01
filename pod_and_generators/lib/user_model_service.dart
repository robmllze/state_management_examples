// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xyz_pod/xyz_pod.dart';

import 'document_service.dart';
import 'models/model_user/model_user.dart';

class UserModelService {
  final pServiceNode = Pod<DocumentService<ModelUser>?>(null);

  Future<void> createService({required String userId}) async {
    pServiceNode.value = await DocumentService.create<ModelUser>(
        FirebaseFirestore.instance.collection("users").doc(userId).withConverter<ModelUser>(
              fromFirestore: (snapshot, _) => ModelUser.fromJMap(snapshot.data()!),
              toFirestore: (model, _) => model.toJMap(),
            ));
    pServiceNode.value?.listen();
  }

  void stopService() async {
    pServiceNode.value?.cancel();
  }
}
