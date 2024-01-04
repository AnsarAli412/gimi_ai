import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gem_ai/models/message_data_model.dart';
import 'package:gem_ai/views/utils/extensions/int_extensions.dart';
import 'package:gem_ai/views/utils/extensions/outline_boader_extensions.dart';
import 'package:gem_ai/views/utils/extensions/widget_extensions.dart';

const emptyMessage = "Hi there!. This is Gimi, how can i assist you?";

class ChatWidgets {
  BuildContext context;

  ChatWidgets({required this.context});

  AppBar appBatView() => AppBar(
        title: const Text("Chat AI"),
      );

  Widget chatItemView(MessageDataModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.request ?? "",
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        5.height,
        HtmlWidget(data.response ?? "")
      ],
    ).paddingAll(10);
  }

  Widget noMessageView() => const Text(
        emptyMessage,
        style: TextStyle(color: Colors.grey),
      );

  Widget sendMessageView(TextEditingController controller, Widget child,
      {void Function(String)? onChanged}) {
    return Row(
      children: [
        TextFormField(
          focusNode: FocusNode(),
          onChanged: onChanged,
          decoration: InputDecoration(
              hintText: "write your words....",
              border: const OutlineInputBorder().textFieldBorder,
              enabledBorder: const OutlineInputBorder().textFieldEnableBorder,
              disabledBorder:
                  const OutlineInputBorder().textFieldDisableBorder),
          controller: controller,
        ).expanded(),
        10.width,
        child
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 10);
  }
}
