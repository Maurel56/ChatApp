// ignore_for_file: constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType {
  Text,
  Image,
  Video,
  Audio,
  Location,
  File,
}

class Message {
  late String? id;
  late String content;
  late String senderId;
  late String receiverId;
  late MessageType type;
  late Timestamp time;
  late bool isRead;
  late bool isDelivered;

  Message({
    this.id,
    required this.content,
    required this.senderId,
    required this.receiverId,
    required this.type,
    required this.time,
    required this.isDelivered,
    required this.isRead,
  });

  factory Message.fromJson(Map<String, dynamic> json, String id) {
    return Message(
      id: id,
      content: json['content'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      type: MessageType.values[json['type']],
      time: json['time'],
      isDelivered: json['isDelivered'],
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'senderId': senderId,
      'receiverId': receiverId,
      'type': type.index,
      'time': time,
      'isDelivered': isDelivered,
      'isRead': isRead,
    };
  }
}
