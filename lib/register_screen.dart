import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  Future<String> register(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "success";
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Simple Firebase Auth"),
          TextField(
            decoration: InputDecoration(hintText: "Email"),
            controller: emailController,
          ),
          TextField(
            decoration: InputDecoration(hintText: "Password"),
            controller: passwordController,
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                var res = await register(
                    emailController.text, passwordController.text);
                if (res == "success") {
                  print("Registered successfully");
                } else {
                  print(res);
                }
              },
              child: Text("Register")),
          SizedBox(
            height: 10,
          ),
          RichText(
              text: TextSpan(text: "Already have an account? ", children: [
            TextSpan(
                text: "Login",
                style: TextStyle(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => LoginPage()))),
                      }),
          ]))
        ]),
      ),
    ));
  }
}
