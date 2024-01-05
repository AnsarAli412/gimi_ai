import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gem_ai/controllers/chat_provider.dart';
import 'package:gem_ai/controllers/speech_provider.dart';
import 'package:gem_ai/views/chats/widgets/chat_widgets.dart';
import 'package:gem_ai/views/speeches/speech_screen.dart';
import 'package:gem_ai/views/utils/extensions/int_extensions.dart';
import 'package:gem_ai/views/utils/extensions/widget_extensions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var gemini = Gemini.instance;
  var messageController = TextEditingController();
  bool isFieldEnable = false;

  @override
  Widget build(BuildContext context) {
    var view = ChatWidgets(context: context);
    return Scaffold(
      appBar: view.appBatView(),
      body: Column(
        children: [
          Consumer<SpeechProvider>(
            builder: (BuildContext context, value, Widget? child) {
              value.initSpeech();
              return Text(value.searchMessage);
            },
          ),
          Consumer<ChatProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return value.messages.isNotEmpty
                  ? ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      itemCount: value.messages.reversed.length,
                      itemBuilder: (c, index) {
                        return Card(
                          child: view.chatItemView(
                            value.messages[index],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return 10.height;
                      },
                    ).expanded()
                  : view.noMessageView().center().expanded();
            },
          ),
          GeminiResponseTypeView(
            builder: (BuildContext context, Widget? child, String? response,
                bool loading) {
              if (loading) {
                return LoadingAnimationWidget.waveDots(
                    color: Colors.blueAccent, size: 40);
              } else {
                messageController.clear();
                return Container();
              }
            },
          ),
          view.sendMessageView(messageController, const SpeechScreen(),
              onChanged: (String? text) {
            var message = Provider.of<ChatProvider>(context, listen: false);
            if (text?.isNotEmpty == true || text != "") {
              message.setMessageEnabled = true;
              message.setMessage = text.toString();
            } else {
              message.setMessageEnabled = false;
            }
          })
        ],
      ),
    );
  }

  @override
  void dispose() {
    messageController.clear();
    super.dispose();
  }
}
