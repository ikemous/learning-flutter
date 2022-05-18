import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flash_chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const String id = 'chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  String? messageText;

  void getCurrentUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void getMessages() async {
    // final cities = _db.collection("cities");
    // final data1 = <String, dynamic>{
    //   "name": "San Francisco",
    //   "state": "CA",
    //   "country": "USA",
    //   "capital": false,
    //   "population": 860000,
    //   "regions": ["west_coast", "norcal"]
    // };
    // cities.doc("SF").set(data1);

    // final data2 = <String, dynamic>{
    //   "name": "Los Angeles",
    //   "state": "CA",
    //   "country": "USA",
    //   "capital": false,
    //   "population": 3900000,
    //   "regions": ["west_coast", "socal"],
    // };
    // cities.doc("LA").set(data2);

    // final data3 = <String, dynamic>{
    //   "name": "Washington D.C.",
    //   "state": null,
    //   "country": "USA",
    //   "capital": true,
    //   "population": 680000,
    //   "regions": ["east_coast"]
    // };
    // cities.doc("DC").set(data3);

    // final data4 = <String, dynamic>{
    //   "name": "Tokyo",
    //   "state": null,
    //   "country": "Japan",
    //   "capital": true,
    //   "population": 9000000,
    //   "regions": ["kanto", "honshu"]
    // };
    // cities.doc("TOK").set(data4);

    // final data5 = <String, dynamic>{
    //   "name": "Beijing",
    //   "state": null,
    //   "country": "China",
    //   "capital": true,
    //   "population": 21500000,
    //   "regions": ["jingjinji", "hebei"],
    // };
    // cities.doc("BJ").set(data5);
    final docRef = _db.collection("cities").doc("SF");
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
    print("TEst");
  }

  @override
  void initState() {
    getCurrentUser();
    getMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: getMessages,
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
