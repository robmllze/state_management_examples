// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;

import 'document_service.dart';
import 'models/user_model/user_model.dart';

class UserModelService {
  final serviceState = UserModelServiceState();

  Future<void> createService({required String userId}) async {
    final temp = await DocumentService.create<UserModel>(
        FirebaseFirestore.instance.collection("users").doc(userId).withConverter<UserModel>(
              fromFirestore: (snapshot, _) {
                final temp = UserModel.fromJson(snapshot.data()!);
                serviceState.documentService?.documentState.set(temp);
                serviceState.notifyListeners();
                return temp;
              },
              toFirestore: (model, _) => model.toJson(),
            ));
    serviceState.set(temp);
    serviceState.listen();
  }

  void stopService() async {
    serviceState.cancel();
  }
}

class UserModelServiceState extends ChangeNotifier {
  DocumentService<UserModel>? _documentService;
  DocumentService<UserModel>? get documentService => _documentService;

  void set(DocumentService<UserModel> documentService) {
    _documentService = documentService;
    notifyListeners();
  }

  void listen() {
    _documentService?.listen();
  }

  void cancel() {
    _documentService?.cancel();
  }
}
