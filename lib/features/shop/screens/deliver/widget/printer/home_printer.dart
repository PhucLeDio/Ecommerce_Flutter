import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/shop/screens/deliver/widget/printer/widgets/invoice_table.dart';
import 'package:flutter_ecommerce/features/shop/screens/deliver/widget/printer/widgets/save_btn_data.dart';
import 'package:flutter_ecommerce/utils/constants/image_strings.dart';

import 'components/image_builder.dart';
import 'components/spacer_printer.dart';

class PrinterHomeScreen extends StatelessWidget {
  const PrinterHomeScreen({super.key, required this.title, required this.id, required this.orderDate, required this.paymentMethod, required this.deliveryDate, required this.address, required this.price});

  final String title;
  final String id;
  final String orderDate;
  final String paymentMethod;
  final String deliveryDate;
  final String address;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25.00),
            child: Column(
              children: [
                Text("Hoang - Phuc",
                    style: TextStyle(
                        fontSize: 25.00, fontWeight: FontWeight.bold)),
                HeightSpacer(myHeight: 10.00),
                Divider(),
                Align(
                  alignment: Alignment.center,
                  child: ImageBuilder(
                    imagePath: TImages.printer,
                    imgWidth: 250,
                    imgheight: 250,
                  ),
                ),
                InvoiceBuilder(id: id, orderDate: orderDate, paymentMethod: paymentMethod, deliveryDate: deliveryDate, address: address, price: price,),
                HeightSpacer(myHeight: 15.00),
                Text(
                  "Thanks for choosing our service!",
                  style: TextStyle(color: Colors.grey, fontSize: 15.00),
                ),
                HeightSpacer(myHeight: 5.00),
                Text(
                  "Contact the branch for any clarifications.",
                  style: TextStyle(color: Colors.grey, fontSize: 15.00),
                ),
                HeightSpacer(myHeight: 15.00),
                SaveBtnBuilder(id: id, orderDate: orderDate, paymentMethod: paymentMethod, deliveryDate: deliveryDate, address: address, price: price,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}