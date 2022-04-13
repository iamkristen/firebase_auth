import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUser extends StatelessWidget {
  AddUser({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;

  Future<String> createData(String name, String age, String gender) async {
    try {
      var doc = await _firestore
          .collection("user")
          .add({"name": name, "age": age, "gender": gender});
      if (doc.id.isNotEmpty) {
        return "success";
      }
      return "failed";
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new user"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "Name",
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "age",
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: genderController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "gender",
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed: () async {
                  var res = await createData(nameController.text,
                      ageController.text, genderController.text);
                  print(res);
                },
                child: Text("Save")),
          ],
        ),
      )),
    );
  }
}
