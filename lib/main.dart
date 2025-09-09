import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholarchat/firebase_options.dart';
import 'package:scholarchat/pages/Chat_page.dart';
import 'package:scholarchat/pages/Register_page.dart';
import 'package:scholarchat/pages/Sign_In.dart';

void main() async {
  //Firebase initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //to check Firebase initialized
  print(' Firebase initialized');
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SignIn.id: (context) => SignIn(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage()
      },
      home: SignIn(),
    );
  }
}
