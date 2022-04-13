import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_authentication/add_user.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD operation"),
        centerTitle: true,
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddUser()));
              },
              child: const Text("Add")),
        ],
      ),
      body: SizedBox.expand(
          child: FutureBuilder(
        future: _firestore.collection("user").get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                        tileColor: Colors.lightBlue[50],
                        title: Text(snapshot.data!.docs[index]["name"]),
                        subtitle: Row(
                          children: [
                            Text("Age: " + snapshot.data!.docs[index]["age"]),
                            const SizedBox(width: 30),
                            Text("Gender: " +
                                snapshot.data!.docs[index]["gender"])
                          ],
                        )),
                  );
                });
          }
          return Text("No data");
        },
      )),
    );
  }
}
