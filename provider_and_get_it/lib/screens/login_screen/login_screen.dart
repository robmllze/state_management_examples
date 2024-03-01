import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            if (FirebaseAuth.instance.currentUser == null)
              TextButton(
                onPressed: () async {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: "robmllze@gmail.com",
                    password: "Testing123",
                  );
                  Navigator.pushNamed(context, "/home");
                },
                child: const Text("Log in as robmllze@gmail.com"),
              )
            else
              TextButton(
                onPressed: () async {
                  Navigator.pushNamed(context, "/home");
                },
                child: const Text("Go to home screen"),
              ),
            TextButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, "/login");
              },
              child: const Text("Log out"),
            ),
          ],
        ),
      ),
    );
  }
}
