// To parse this JSON data, do
//
//     final messageDataModel = messageDataModelFromJson(jsonString);

import 'dart:convert';

MessageDataModel messageDataModelFromJson(String str) => MessageDataModel.fromJson(json.decode(str));

String messageDataModelToJson(MessageDataModel data) => json.encode(data.toJson());

class MessageDataModel {
  String? request;
  String? response;

  MessageDataModel({
    this.request,
    this.response,
  });

  factory MessageDataModel.fromJson(Map<String, dynamic> json) => MessageDataModel(
    request: json["request"],
    response: json["response"],
  );

  Map<String, dynamic> toJson() => {
    "request": request,
    "response": response,
  };
}
