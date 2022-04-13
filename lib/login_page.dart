import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/home_screen.dart';
import 'package:firebase_authentication/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _firebaseAuth = FirebaseAuth.instance;

  Future<String> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
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
                var res =
                    await login(emailController.text, passwordController.text);
                if (res == "success") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } else {
                  print(res);
                }
              },
              child: Text("Login")),
          SizedBox(
            height: 10,
          ),
          RichText(
              text: TextSpan(text: "Don't have an account? ", children: [
            TextSpan(
                text: "Register",
                style: TextStyle(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => RegisterScreen()))),
                      }),
          ]))
        ]),
      ),
    ));
  }
}
