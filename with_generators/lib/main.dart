import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '/firebase_options.dart';
import '/screens/home_screen/home_screen.dart';
import '/screens/login_screen/login_screen.dart';
import 'user_model_service.dart';

final userModelService = UserModelService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo: State Management with the Pod",
      initialRoute: "/",
      routes: {
        "/": (context) {
          return FirebaseAuth.instance.currentUser != null
              ? const HomeScreen(title: "Home")
              : const LoginScreen(title: "Login");
        },
        "/home": (context) => const HomeScreen(title: "Home"),
        "/login": (context) => const LoginScreen(title: "Login"),
      },
    );
  }
}

Future<void> initApp() async {
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Start and stop the user service based on the user's authentication state.
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user != null) {
      userModelService.createService(userId: user.uid);
    } else {
      userModelService.stopService();
    }
  });
}
