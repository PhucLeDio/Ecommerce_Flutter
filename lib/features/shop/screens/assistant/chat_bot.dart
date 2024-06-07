import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../utils/constants/colors.dart';

class ViewChatBot extends StatefulWidget {
  const ViewChatBot({super.key});

  @override
  State<ViewChatBot> createState() => _ViewChatBotState();
}

class _ViewChatBotState extends State<ViewChatBot> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://chatgpt.com/"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        title: Text("ChatBot panel"),
      ),

      body: WebViewWidget(controller: controller,),
    );
  }
}