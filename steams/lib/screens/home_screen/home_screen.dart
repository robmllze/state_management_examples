import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:state_management_with_streams/screens/home_screen/widgets/user_details_widget.dart';

import '/model_utils/user_model_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream<DocumentSnapshot<Map<String, dynamic>>>? userDocumentStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const UserDetailsWidget(),
            const SizedBox(height: 20.0),
            ...UserRoles.values.map((role) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () {
                    UserModelUtils.changeCurrentUserRole(role);
                  },
                  child: Text("Change current role to: ${role.name.toString()}"),
                ),
              );
            }).toList(),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () async {
                Navigator.pushNamed(context, "/login");
              },
              child: const Text("Go to login screen"),
            ),
          ],
        ),
      ),
    );
  }
}
