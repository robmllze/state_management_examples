import 'package:flutter/material.dart';
import 'package:xyz_pod/xyz_pod.dart';

import '/main.dart';
import '/models/model_user/model_user.dart';
import '/model_utils/user_model_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //

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
          children: [
            const Text("Using a native Flutter ValueListenableBuilder:",
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 8.0),
            // OPTION 1 - This is the native Flutter approach to listening to
            // changes in multiple Pods. It's the least efficient of the three
            // and also quite a few lines. Imagine we're wathing 10 Pods, we'd
            // have to nest 10 ValueListenableBuilders! Also, notice how
            // we don't strictly need to use a PodBuilder here. This is because
            // the PodBuilder and ValueListenableBuilder are completely
            // exchangeable.
            ValueListenableBuilder(
              valueListenable: userModelService.pServiceNode,
              builder: (context, documetnService, child) {
                final pDocumentNode = documetnService?.pDocumentNode;
                if (pDocumentNode != null) {
                  return ValueListenableBuilder(
                    key: UniqueKey(),
                    valueListenable: pDocumentNode,
                    builder: (context, userModel, child) {
                      return Column(
                        children: [
                          Text("Current User Role: ${userModel?.role}"),
                          Text("Current User ID: ${userModel?.id}"),
                          Text("Current User Public ID: ${userModel?.userPubId}"),
                        ],
                      );
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(height: 20.0),
            const Text("Using a PollingPodBuilder:", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 8.0),
            // OPTION 2 - This approach functions by continuously calling the
            // poll function, once per frame, until the poll function returns a
            // Pod instead of null. When it returns a Pod, it stops polling and
            // the Pod then gets watched for changes. Once it changes, the
            // builder is called. This method is less efficient compared to
            // OPTION 3 bewlo, but the impact on performance might be negligible.
            // This method has not been tested for performance.
            PollingPodBuilder(
              poll: () => userModelService.pServiceNode.value?.pDocumentNode,
              builder: (context, child, userModel) {
                if (userModel != null) {
                  return Column(
                    children: [
                      Text("Current User Role: ${userModel.role}"),
                      Text("Current User ID: ${userModel.id}"),
                      Text("Current User Public ID: ${userModel.userPubId}"),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(height: 20.0),
            const Text("Using a RespondingPodListBuilder:", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 8.0),
            // OPTION 3 - This approach is more efficient than OPTION 2 but it
            // is longer and takes a moment to understand. It works by watching
            // all of the non-null Pods returned podListResponder. If any of
            // them change, builder is called, as well as the podListResponder,
            // which in turn regenerates the list of Pods to watch. This ensures
            // that as soon as any Pod becomes available (i.e., non-null), it's
            // immediately watched for updates.
            RespondingPodListBuilder(
              podListResponder: () => [
                userModelService.pServiceNode,
                userModelService.pServiceNode.value?.pDocumentNode,
              ],
              builder: (context, child, values) {
                final userModel = values.second as ModelUser?;
                if (userModel != null) {
                  return Column(
                    children: [
                      Text("Current User Role: ${userModel.role}"),
                      Text("Current User ID: ${userModel.id}"),
                      Text("Current User Public ID: ${userModel.userPubId}"),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
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
