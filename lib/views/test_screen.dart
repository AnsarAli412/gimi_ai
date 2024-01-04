import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gem_ai/models/message_data_model.dart';
import 'package:gem_ai/views/chats/widgets/chat_widgets.dart';
import 'package:gem_ai/views/utils/extensions/widget_extensions.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String data = "";

  @override
  Widget build(BuildContext context) {
    var view = ChatWidgets(context: context);
    var chats = <MessageDataModel>[];
    // var Sst = [
    //   Content(role: "user", parts: [Parts(text: "user is your questions")]),
    //   Content(role: "model", parts: [Parts(text: "user is AI answer")])
    // ];
    // chats.add(MessageDataModel(
    //     ai: Ai(
    //         content:
    //             Contents(role: "user", parts: [Part(text: "this is ai")])),
    //     user: Ai(
    //         content:
    //             Contents(role: "ai", parts: [Part(text: "this is user")]))));
    // chats.add(Content(role: "user",parts: [Parts(text: "user is your questions")]));
    // chats.add(Content(role: "model",parts: [Parts(text: "user is AI answer")]));
    // chats.add(Content(role: "user",parts: [Parts(text: "user is your questions")]));
    // chats.add(Content(role: "model",parts: [Parts(text: "user is AI answer")]));
    // chats.add(Content(role: "user",parts: [Parts(text: "user is your questions")]));
    // chats.add(Content(role: "model",parts: [Parts(text: "user is AI answer")]));
    return Scaffold(
        body: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            itemBuilder: (c, i) {
              return Card(
                child: Column(
                  children: [
                    // Text(chats[i].ai?.content?.parts![0].text??""),
                    // Text(chats[i].user?.content?.parts![0].text??"")
                  ],
                ),
              );
            },
            separatorBuilder: (c, i) {
              return Divider();
            },
            itemCount: chats.length));
  }
}
