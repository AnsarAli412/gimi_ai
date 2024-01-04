import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechProvider with ChangeNotifier{

  SpeechToText get speechToText => SpeechToText();

  bool _speechEnabled = false;
  bool get isSpeechEnabled => _speechEnabled;

  void initSpeech() async {
    _speechEnabled = await speechToText.initialize();
    notifyListeners();
  }

  void startListening() async {
    await speechToText.listen(onResult: _onSpeechResult);
    notifyListeners();
  }

  void stopListening() async {
    await speechToText.stop();
    notifyListeners();
  }

  String _searchMessage = "";
  String get searchMessage => _searchMessage;

  void _onSpeechResult(SpeechRecognitionResult result) {
    _searchMessage = result.recognizedWords;
    notifyListeners();
  }
}