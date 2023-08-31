import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/models/message_model.dart';
import 'package:uuid/uuid.dart';

class ChatProvider extends ChangeNotifier {
  final TextEditingController chatController = TextEditingController();

  Future<void> onMessageSent({required String userUid, required String chatRoomId}) async {
    String singleChatId = const Uuid().v1();
    if (chatController.text.isNotEmpty) {
      MessagModel messageModel = MessagModel(
        sendBy: userUid,
        message: chatController.text,
        chatId: singleChatId,
        chatRoomId: chatRoomId,
        createdOn: FieldValue.serverTimestamp(),
        seen: false,
      );

      await FirebaseFirestore.instance.collection('chatRoom').doc(chatRoomId).collection('chats').doc(singleChatId).set(
            messageModel.toJson(),
          );
      chatController.clear();
    } else {
      log('type anything');
    }
  }

  disposeChatController() {
    chatController.clear();
    notifyListeners();
  }
}
