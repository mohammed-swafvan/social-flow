import 'package:cloud_firestore/cloud_firestore.dart';

class MessagModel {
  String? sendBy;
  bool? seen;
  String? message;
  FieldValue? createdOn;
  String? chatId;
  String? chatRoomId;

  MessagModel({
    required this.sendBy,
    required this.message,
    required this.chatId,
    required this.chatRoomId,
    this.seen,
    this.createdOn,
  });

  MessagModel.fromJson(Map<String, dynamic> json) {
    sendBy = json['sendBy'];
    seen = json['seen'];
    message = json['message'];
    createdOn = json['createdOn'];
    chatId = json['chatId'];
    chatRoomId = json['chatRoomId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'sendBy': sendBy,
      'seen': seen,
      'message': message,
      'createdOn': createdOn,
      'chatId': chatId,
      'chatRoomId':chatRoomId,
    };
  }
}

class MessageModelTwo {
  String? sendBy;
  bool? seen;
  String? message;
  DateTime? createdOn;
  String? chatId;
  String? chatRoomId;

  MessageModelTwo({
    required this.sendBy,
    required this.message,
    required this.chatId,
    required this.chatRoomId,
    this.seen,
    this.createdOn,
  });

  MessageModelTwo.fromJson(Map<String, dynamic> json) {
    sendBy = json['sendBy'];
    seen = json['seen'];
    message = json['message'];
    createdOn = json['createdOn'];
     chatId = json['chatId'];
    chatRoomId = json['chatRoomId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'sendBy': sendBy,
      'seen': seen,
      'message': message,
      'createdOn': createdOn,
      'chatId': chatId,
      'chatRoomId':chatRoomId,
    };
  }
}
