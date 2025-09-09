import 'package:flutter/material.dart';
import 'package:scholarchat/model/message.dart';

class ChatBubbleFriend extends StatelessWidget {
  const ChatBubbleFriend({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
              color: const Color(0xFF68B8DA),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomLeft: Radius.circular(32),
              )),
          child: Text(message.message, style: TextStyle(color: Colors.white))),
    );
  }
}
