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
  ..loadRequest(Uri.parse("https://www.google.com/maps/dir/100+T%C3%B4n+%C4%90%E1%BB%A9c+Th%E1%BA%AFng,+H%C3%B2a+An,+C%E1%BA%A9m+L%E1%BB%87,+%C4%90%C3%A0+N%E1%BA%B5ng/Tr%C6%B0%E1%BB%9Dng+%C4%90%E1%BA%A1i+h%E1%BB%8Dc+C%C3%B4ng+ngh%E1%BB%87+Th%C3%B4ng+tin+v%C3%A0+Truy%E1%BB%81n+th%C3%B4ng+Vi%E1%BB%87t+-+H%C3%A0n,+470+%C4%90.+Tr%E1%BA%A7n+%C4%90%E1%BA%A1i+Ngh%C4%A9a,+Khu+%C4%91%C3%B4+th%E1%BB%8B,+Ng%C5%A9+H%C3%A0nh+S%C6%A1n,+%C4%90%C3%A0+N%E1%BA%B5ng+550000,+Vi%E1%BB%87t+Nam/@16.0195577,108.1922553,13z/data=!4m13!4m12!1m5!1m1!1s0x314219053e0bd53f:0xd620f77685b9f191!2m2!1d108.1798314!2d16.0581545!1m5!1m1!1s0x3142108997dc971f:0x1295cb3d313469c9!2m2!1d108.252355!2d15.9752931?hl=vi-VN&entry=ttu"));

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