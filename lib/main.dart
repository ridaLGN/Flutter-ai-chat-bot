import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat/presentation/chat_provider.dart';
import 'chat/presentation/chat_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatPage(),
    );
  }
}
