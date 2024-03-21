import 'package:flutter/material.dart';

import '../models/message_data_model.dart';

class ChatProvider with ChangeNotifier {

  bool _hasMessage = false;
  bool get hasMessage => _hasMessage;

  set setMessageEnabled(bool value) {
    _hasMessage = value;
    notifyListeners();
  }

  String _searchMessage = "";
  String get searchMessage => _searchMessage;

  set setMessage(String searchText) {
    _searchMessage = searchText;
    notifyListeners();
  }

  List<MessageDataModel> _messages = <MessageDataModel>[];

  List<MessageDataModel> get messages => _messages;

  Future<List<MessageDataModel>> setChatMessage(
      List<MessageDataModel> currentMessage) async {
    _messages.addAll(currentMessage);
    notifyListeners();
    return _messages;
  }
}
