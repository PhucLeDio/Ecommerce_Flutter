import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../utils/constants/colors.dart';

class ViewMap extends StatefulWidget {
  const ViewMap({super.key});

  @override
  State<ViewMap> createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {
  final controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse("https://www.google.com/maps/place/Tr%C6%B0%E1%BB%9Dng+%C4%91%E1%BA%A1i+h%E1%BB%8Dc+CNTT-TT+Vi%E1%BB%87t+-+H%C3%A0n/@16.0020907,108.2118102,14z/data=!4m20!1m13!4m12!1m4!2m2!1d108.2127458!2d16.0284223!4e1!1m6!1m2!1s0x314219b7501de701:0xd8f61319afabaab2!2zVHLGsOG7nW5nIMSR4bqhaSBo4buNYyBDTlRULVRUIFZp4buHdCAtIEjDoG4sIMSQxrDhu51uZyBUcuG6p24gxJDhuqFpIE5naMSpYSwgSMOyYSBRdcO9LCBOZ8WpIEjDoG5oIFPGoW4sIMSQw6AgTuG6tW5n!2m2!1d108.2534751!2d15.9752144!3m5!1s0x314219b7501de701:0xd8f61319afabaab2!8m2!3d15.9752144!4d108.2534751!16s%2Fg%2F11b66h7qrn?hl=vi-VN&entry=ttu"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        title: Text("Delivery Map"),
      ),

      body: WebViewWidget(controller: controller,),
    );
  }
}