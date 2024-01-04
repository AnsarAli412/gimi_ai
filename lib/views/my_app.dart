import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gem_ai/controllers/speech_provider.dart';
import 'package:gem_ai/views/utils/builders/sheet_builders.dart';
import 'package:gem_ai/views/utils/extensions/context_extensions.dart';
import 'package:gem_ai/views/utils/extensions/int_extensions.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // SpeechToText _speechToText = SpeechToText();
  // bool _speechEnabled = false;
  // String _lastWords = '';

  @override
  void initState() {
    super.initState();
    // _initSpeech();
    // showMyDialog();
  }

  showMyDialog(){
    Future.delayed(1.seconds,(){
      var speech = Provider.of<SpeechProvider>(context).speechToText;
      if(speech.isListening){
        SheetBuilders().showDialogOnTop(context);
      }
    });
  }

  /// This has to happen only once per app
  // void _initSpeech() async {
  //   _speechEnabled = await _speechToText.initialize();
  //   setState(() {});
  // }
  //
  // /// Each time to start a speech recognition session
  // void _startListening() async {
  //   await _speechToText.listen(onResult: _onSpeechResult);
  //   setState(() {});
  // }
  //
  // /// Manually stop the active speech recognition session
  // /// Note that there are also timeouts that each platform enforces
  // /// and the SpeechToText plugin supports setting timeouts on the
  // /// listen method.
  // void _stopListening() async {
  //   await _speechToText.stop();
  //   setState(() {});
  // }
  //
  // /// This is the callback that the SpeechToText plugin calls when
  // /// the platform returns recognized words.
  // void _onSpeechResult(SpeechRecognitionResult result) {
  //   setState(() {
  //     _lastWords = result.recognizedWords;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Demo'),
      ),
      body: Consumer<SpeechProvider>(
        builder: (BuildContext context, value, Widget? child) {
          value.initSpeech();
          var _speechToText = value.speechToText;
          var _lastWords = value.searchMessage;
          var _speechEnabled = value.isSpeechEnabled;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: const Text(
                    'Recognized words:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      // If listening is active show the recognized words
                      _speechToText.isListening
                          ? _lastWords
                          // If listening isn't active but could be tell the user
                          // how to start it, otherwise indicate that speech
                          // recognition is not yet ready or not supported on
                          // the target device
                          : _speechEnabled
                              ? 'Tap the microphone to start listening...'
                              : 'Speech not available',
                    ),
                  ),
                ),
                ElevatedButton(onPressed: () {
                  SheetBuilders().showDialogOnTop(context);
                  // SheetBuilders().showTopModalSheet(context, SizedBox(
                  //   height: 200,
                  //   width: context.fullWidth,
                  //   child: Text("Top sheet"),
                  // ));
                }, child: Text("Top sheet")),
                InkWell(
                  onLongPress: (){
                    if(_speechToText.isListening){
                      SheetBuilders().showDialogOnTop(context);
                    }else{
                      Fluttertoast.showToast(msg: "Not listening");
                    }
                  },
                  onTap:(){
                    _speechToText.isNotListening
                        ? value.startListening()
                        : value.stopListening();
                  },
                  child: Container(
                    color: Colors.red,
                    height: 50,
                    width: 50,
                    // onPressed:(){},
                    // // If not yet listening for speech start, otherwise stop
                    // // _speechToText.isNotListening ? _startListening : _stopListening,
                    // tooltip: 'Listen',
                    child: Icon(_speechToText.isNotListening
                        ? Icons.mic_off
                        : Icons.mic),
                  ),
                )
              ],
            ),
          );
        },
      ),
      // floatingActionButton: InkWell(
      //   onLongPress: (){
      //     _speechToText.isNotListening ? _startListening : _stopListening;
      //   },
      //   child: Container(
      //     color: Colors.red,
      //     height: 50,
      //     width: 50,
      //     // onPressed:(){},
      //     // // If not yet listening for speech start, otherwise stop
      //     // // _speechToText.isNotListening ? _startListening : _stopListening,
      //     // tooltip: 'Listen',
      //     child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      //   ),
      // ),
    );
  }
}
