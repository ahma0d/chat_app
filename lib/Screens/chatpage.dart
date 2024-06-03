import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constant/constant.dart';

import '../Model/message.dart';
import '../Widget/chatpubble.dart';

class chatpage extends StatelessWidget {
  static String id = 'chatpage';
  var index = 5;
  final controller1 = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection('Messages');
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kcreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        List<Message> messagesList = [];
        for (int i = 0; i < snapshot.data!.docs.length; i++) {
          messagesList.add(
            Message.frowmJson(snapshot.data!.docs[i]),
          );
        }
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    klogo,
                    height: 40,
                  ),
                  Text('Chat'),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: controller1,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? chatbubble(
                              message: messagesList[index],
                            )
                          : chatbubbleforfrend(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        kmesaage: data,
                        kcreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                      controller1.animateTo(
                        0,
                        duration: Duration(seconds: 30),
                        curve: Curves.bounceInOut,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'send message',
                      suffixIcon: Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text(
            'ahmad awad',
            style: TextStyle(fontSize: 55),
          );
        }
      },
    );
  }
}
