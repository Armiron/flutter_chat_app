import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Hello'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/ra4anI7XuHGPyMKElc8w/messages')
              .snapshots()
              .listen(
            (data) {
              data.docs.forEach((doc) {
                print(doc['text']);
              });
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
