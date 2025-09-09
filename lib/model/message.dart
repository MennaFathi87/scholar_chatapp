import 'package:scholarchat/constant.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);

  factory Message.fromJson(Map<String, dynamic> jsonData) {
    return Message(
      (jsonData[kMessage] ?? '').toString(),
      (jsonData['id'] ?? '').toString(),
    );
  }
}
