import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/models/message_model.dart';

class ChatProvider extends ChangeNotifier {
  final TextEditingController chatController = TextEditingController();

  onMessageSent({required String userUid, required String chatRoomId}) async {
    if (chatController.text.isNotEmpty) {
      MessagModel messageModel = MessagModel(
        sendBy: userUid,
        message: chatController.text,
        createdOn: FieldValue.serverTimestamp(),
        seen: false,
      );

      await FirebaseFirestore.instance.collection('chatRoom').doc(chatRoomId).collection('chats').add(
            messageModel.toJson(),
          );
      chatController.clear();
    } else {
      log('type anything');
    }
  }
}
