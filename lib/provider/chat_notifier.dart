import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:social_flow/models/chat_model.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/services/chat_services.dart';
import 'package:social_flow/services/firestore_services.dart';

class ChatNotifier extends ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? chatStream;
  TextEditingController messageController = TextEditingController();
  bool isLoading = false;
  String chatRoomId = '';
  List<ChatModel> chats = [];

  void getChatStream() async {
    chatStream = FirestoreServices().getChatStream(chatRoomId: chatRoomId);
    notifyListeners();
  }

  getChatRoomId({required UserModel user}) async {
    isLoading = true;
    notifyListeners();
    final FirebaseAuth auth = FirebaseAuth.instance;
    String id = ChatServices().chatId(chatingUserId: user.uid, currentUserId: auth.currentUser!.uid);
    chatRoomId = id;
    isLoading = false;
    notifyListeners();
  }

  Future<void> onMessageSent({required String chatRoomId}) async {
    if (messageController.text.isNotEmpty) {
      final FirebaseAuth auth = FirebaseAuth.instance;
      String chatId = randomAlphaNumeric(10);
      DateTime currentDate = DateTime.now();
      String formatedTime = DateFormat('h:mma').format(currentDate);
      ChatModel chat = ChatModel(
        sendBy: auth.currentUser!.uid,
        message: messageController.text,
        createdOn: currentDate,
        formatedTime: formatedTime,
        chatRoomId: chatRoomId,
        chatId: chatId,
      );
      await FirestoreServices().uploadChat(chat: chat);
      messageController.clear();
      notifyListeners();
    }
  }

  Future<void> deleteMessage({required BuildContext context, required String chatRoomId, required String chatId}) async {
    return Utils().showDialogBox(
      context: context,
      onTap: () async {
        try {
          Navigator.pop(context);
          await FirestoreServices().deleteMessage(chatRoomId: chatRoomId, messageId: chatId);
        } catch (e) {
          if (context.mounted) {
            Navigator.pop(context);
            Utils().customSnackBar(context: context, content: "Something went wrong, please try again!");
          }
        }
      },
      title: "Delete!",
      content: "Are you sure, you want to delete the message?",
    );
  }

  addDate({required List<QueryDocumentSnapshot<Map<String, dynamic>>> chatDocs}) async {
    chats.clear();
    for (var doc in chatDocs) {
      DateTime currentDate = DateTime.now();
      DateTime date = doc['created_on'] == null ? currentDate : (doc['created_on'] as Timestamp).toDate();
      String formatedTime = DateFormat('h:mma').format(date);
      chats.add(
        ChatModel(
          sendBy: doc['send_by'],
          message: doc['message'],
          createdOn: date,
          formatedTime: formatedTime,
          chatRoomId: doc['chat_room_id'],
          chatId: doc['chat_id'],
        ),
      );
    }
  }
}
