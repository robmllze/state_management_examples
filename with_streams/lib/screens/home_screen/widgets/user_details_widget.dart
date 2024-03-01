import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/models/user_model/user_model.dart';

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            if (user != null) {
              final userDocumentStream = FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .snapshots();
              return StreamBuilder(
                  stream: userDocumentStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data?.data();
                    if (data != null) {
                      final model = UserModel.fromJson(data);
                      return Column(
                        children: [
                          Text("Current User Role: ${model.role}"),
                          Text("Current User ID: ${model.id}"),
                          Text("Current User Public ID: ${model.user_pub_id}"),
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  });
            }
          }
          return const CircularProgressIndicator();
        });
  }
}
