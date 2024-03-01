import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '/user_model_service.dart';

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GetIt.instance<UserModelServiceState>(),
      child: Consumer<UserModelServiceState>(
        builder: (context, serviceState, child) {
          final userModel = serviceState.documentService?.documentState.document;
          if (userModel != null) {
            return Column(
              children: [
                Text("Current User Role: ${userModel.role}"),
                Text("Current User ID: ${userModel.id}"),
                Text("Current User Public ID: ${userModel.user_pub_id}"),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
