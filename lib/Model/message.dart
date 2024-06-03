import '../constant/constant.dart';

class Message {
  final String messages;
  final String id;
  Message({required this.id, required this.messages});

  factory Message.frowmJson(jsonData) {
    return Message(
      messages: jsonData[kmesaage],
      id: jsonData['id'],
    );
  }
}
