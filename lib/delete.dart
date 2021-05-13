import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_application_1/main.dart';

class Delete extends StatelessWidget {
  Future<void> delete(context) async {
    try {
      await FirebaseAuth.instance.currentUser.delete();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) => MyApp()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  Future<void> update() async {
    String email = 'new@gmail.com';
    String password = 'new456';
    EmailAuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    await FirebaseAuth.instance.currentUser
        .reauthenticateWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            child: Text("Delete Account"),
            onPressed: () {
              delete(context);
            },
          ),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
            child: Text("Update Account"),
            onPressed: () {
              update();
            },
          ),
        ]),
      ),
    );
  }
}
