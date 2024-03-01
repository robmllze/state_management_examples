// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:async' show StreamSubscription;
import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference;

class DocumentService<T> {
  final DocumentReference<T> documentReference;

  DocumentService._({
    required this.documentReference,
  });

  final documentNode = ValueNotifier<T?>(null);

  StreamSubscription? _subscription;

  static Future<DocumentService<T>> create<T>(
    DocumentReference<T> documentReference,
  ) async {
    final instance = DocumentService<T>._(documentReference: documentReference);
    // Get the initial data upon creation of the service.
    instance.documentNode.value = (await documentReference.get()).data();
    instance.documentNode.notifyListeners();
    return instance;
  }

  void listen() {
    // Update the data node when the document changes on Firestore
    _subscription = documentReference.snapshots().listen((event) {
      documentNode.value = event.data();
      documentNode.notifyListeners();
    });
  }

  void cancel() {
    _subscription?.cancel();
  }
}
