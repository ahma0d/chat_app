import 'package:flutter/material.dart';
import 'package:scholar_chat/Model/message.dart';

import '../constant/constant.dart';

class chatbubble extends StatelessWidget {
  const chatbubble({required this.message, super.key});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(
          left: 15,
          top: 25,
          bottom: 25,
          right: 30,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: kPrimaryColor,
        ),
        child: Text(
          message.messages!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class chatbubbleforfrend extends StatelessWidget {
  const chatbubbleforfrend({required this.message, super.key});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(
          left: 15,
          top: 25,
          bottom: 25,
          right: 30,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Colors.red,
        ),
        child: Text(
          message.messages!,
          style: TextStyle(
            color: Color(0xff006D84),
          ),
        ),
      ),
    );
  }
}
