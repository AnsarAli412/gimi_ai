import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gem_ai/controllers/chat_provider.dart';
import 'package:gem_ai/controllers/speech_provider.dart';
import 'package:gem_ai/models/message_data_model.dart';
import 'package:provider/provider.dart';

class SpeechWidgets {
  BuildContext context;

  SpeechWidgets({required this.context});

  Widget sendMessageView() {
    return Consumer<ChatProvider>(
      builder: (BuildContext context, chatProvider, Widget? child) {
        return CircleAvatar(
          radius: 30,
          child: IconButton(
              onPressed: () {
                var searchMessage = chatProvider.searchMessage;
                responseMessages(searchMessage);
              },
              icon: const Icon(
                // size: 30,
                Icons.send_outlined,
                color: Colors.white,
              )),
        );
      },
    );
  }

  Widget sendSpeechView() {
    return Consumer<SpeechProvider>(
      builder: (BuildContext context, speech, Widget? child) {
        speech.initSpeech();
        var chatProvider = Provider.of<ChatProvider>(context, listen: false);
        var speechToText = speech.speechToText;

        return GestureDetector(
          onTap: () {
            speechToText.isNotListening
                ? speech.startListening
                : speech.stopListening;
            chatProvider.searchSetMessage = speech.searchMessage;
            responseMessages(chatProvider.searchMessage);
          },
          child: CircleAvatar(
              radius: 30,
              child: Icon(speech.speechToText.isNotListening
                  ? Icons.mic_off
                  : Icons.mic)),
        );
      },
    );
  }

  responseMessages(String searchMessage) {
    final List<MessageDataModel> currentMessage = <MessageDataModel>[];
    var gemini = Gemini.instance;
    if (searchMessage != "" || searchMessage.isNotEmpty) {
      var data = Content(role: "user", parts: [Parts(text: searchMessage)]);
      gemini.chat([data]).then((value) {
        currentMessage
            .add(MessageDataModel(request: searchMessage,response: value?.output));
        Provider.of<ChatProvider>(context, listen: false)
            .setChatMessage(currentMessage);
      });
    }
  }
}
