import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String sendBy;
  final String message;
  final DateTime createdOn;
  final String formatedTime;
  final String chatRoomId;
  final String chatId;

  ChatModel({
    required this.sendBy,
    required this.message,
    required this.createdOn,
    required this.formatedTime,
    required this.chatRoomId,
    required this.chatId,
  });

  Map<String, dynamic> toJson() => {
        "send_by": sendBy,
        "message": message,
        "created_on": createdOn,
        "formated_time": formatedTime,
        "chat_room_id": chatRoomId,
        "chat_id": chatId,
      };

  static ChatModel fromSnapShot(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return ChatModel(
      sendBy: snapShot['send_by'],
      message: snap['message'],
      createdOn: snapShot['created_on'],
      formatedTime: snapShot['formated_time'],
      chatRoomId: snapShot['chat_room_id'],
      chatId: snapShot['chat_id'],
    );
  }
}
