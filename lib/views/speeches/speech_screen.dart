import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gem_ai/controllers/speech_provider.dart';
import 'package:gem_ai/models/message_data_model.dart';
import 'package:provider/provider.dart';

import '../../controllers/chat_provider.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({
    super.key,
  });

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatProvider, SpeechProvider>(
      builder:
          (BuildContext context, chatProvider, speechProvider, Widget? child) {
        return chatProvider.hasMessage
            ? CircleAvatar(
                backgroundColor: Colors.deepPurple,
                radius: 30,
                child: IconButton(
                    onPressed: () {
                      var searchMessage = chatProvider.searchMessage;
                      responseMessages(searchMessage);
                    },
                    icon: const Icon(
                      Icons.send_outlined,
                      color: Colors.white,
                    )),
              )
            : GestureDetector(
                onTap: () {
                  speechProvider.speechToText.isNotListening
                      ? speechProvider.startListening()
                      : speechProvider.stopListening();
                  if (speechProvider.searchMessage.isNotEmpty ||
                      speechProvider.searchMessage != "") {
                    responseMessages(speechProvider.searchMessage);
                  }
                },
                child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.deepPurple,
                    child: Icon(speechProvider.speechToText.isNotListening
                        ? Icons.mic_off
                        : Icons.mic,color: Colors.white,)),
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
        currentMessage.add(
            MessageDataModel(request: searchMessage, response: value?.output));
        Provider.of<ChatProvider>(context, listen: false)
            .setChatMessage(currentMessage);
      });
    }
  }

  searchMessageRequest(String message){
    final List<MessageDataModel> currentMessage = <MessageDataModel>[];
    var gemini = Gemini.instance;
    if (message != "" || message.isNotEmpty) {
      // var data = Content(role: "user", parts: [Parts(text: message)]);
      gemini.streamGenerateContent(message).listen((event) {
        currentMessage.add(
            MessageDataModel(request: message, response: event.output));
        Provider.of<ChatProvider>(context, listen: false)
            .setChatMessage(currentMessage);
      });
    }

  }
}
