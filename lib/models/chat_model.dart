import 'package:flutter/material.dart';

class ChatModel {
  static const String _SENDER_ID = "senderUserId";
  static const String _RECIEVER_ID = "recieverUserId";
  static const String _MESSAGE_ID = "messageId";
  static const String _CONTENT = "content";
  static const String _MESSAGE_TIME = "messageTime";

  String senderUserId, recieverUserId, messageId, content, messageTime;

  ChatModel({
    @required this.senderUserId,
    @required this.recieverUserId,
    @required this.messageId,
    @required this.content,
    @required this.messageTime,
  });
  ChatModel.fromJson(Map<String, dynamic> map) {
    this.senderUserId = map[_SENDER_ID];
    this.recieverUserId = map[_RECIEVER_ID];
    this.messageId = map[_MESSAGE_ID];
    this.content = map[_CONTENT];
    this.messageTime = map[_MESSAGE_TIME];
  }

  static Map<String, dynamic> toJson(ChatModel model) => {
        _SENDER_ID: model.senderUserId,
        _RECIEVER_ID: model.recieverUserId,
        _MESSAGE_ID: model.messageId,
        _CONTENT: model.content,
        _MESSAGE_TIME: model.messageTime,
      };
}
