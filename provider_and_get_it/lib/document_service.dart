// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:async' show StreamSubscription;
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference;

class DocumentService<T> {
  final DocumentReference<T> documentReference;

  DocumentService._({
    required this.documentReference,
  });

  final documentState = DocumentState<T?>();

  StreamSubscription? _subscription;

  static Future<DocumentService<T>> create<T>(
    DocumentReference<T> documentReference,
  ) async {
    final instance = DocumentService<T>._(documentReference: documentReference);
    // Get the initial data upon creation of the service.
    final temp = (await documentReference.get()).data();
    instance.documentState.set(temp);
    return instance;
  }

  void listen() {
    // Update the data node when the document changes on Firestore
    _subscription = documentReference.snapshots().listen((event) {
      documentState.set(event.data());
      documentState.notifyListeners();
    });
  }

  void cancel() {
    _subscription?.cancel();
  }
}

class DocumentState<T> extends ChangeNotifier {
  T? _document;
  T? get document => _document;

  void set(T? newModel) {
    _document = newModel;
    notifyListeners();
  }
}
