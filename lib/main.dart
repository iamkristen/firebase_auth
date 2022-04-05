import 'package:firebase_authentication/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD_iYI3AnEUNEu7xcMsR5OYmfaW8fngfpA",
            appId: "1:42573132332:web:6c63b3cb7cb6e48e741789",
            messagingSenderId: "42573132332",
            projectId: "fir-auth-c5913"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Firebase Auth",
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
