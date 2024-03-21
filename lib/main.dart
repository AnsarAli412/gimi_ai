import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gem_ai/controllers/chat_provider.dart';
import 'package:gem_ai/controllers/speech_provider.dart';
import 'package:gem_ai/views/chats/chat_screen.dart';
import 'package:gem_ai/views/test_screen.dart';
import 'package:gem_ai/views/utils/keys.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ChatProvider>(create: (c) => ChatProvider()),
      ChangeNotifierProvider<SpeechProvider>(create: (c) => SpeechProvider())
    ],
    child: const MyApp(),
  ));
  Gemini.init(apiKey: geminiKey, enableDebugging: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gem AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const ChatScreen(),
    );
  }
}
