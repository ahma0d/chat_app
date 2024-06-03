import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/Screens/chatpage.dart';
import 'package:scholar_chat/Screens/regester.dart';
import 'package:scholar_chat/firebase_options.dart';

import 'Screens/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const scholarChat());
}

class scholarChat extends StatelessWidget {
  const scholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        logIn.id: (context) => logIn(),
        registerpage.id: (context) => registerpage(),
        chatpage.id: (context) => chatpage(),
      },
      initialRoute: logIn.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
