import 'package:flutter/material.dart';

import '../components/spacer_printer.dart';

class InvoiceBuilder extends StatefulWidget {
  const InvoiceBuilder({super.key, required this.id, required this.orderDate, required this.paymentMethod, required this.deliveryDate, required this.address, required this.price});

  final String id;
  final String orderDate;
  final String paymentMethod;
  final String deliveryDate;
  final String address;
  final String price;

  @override
  State<InvoiceBuilder> createState() => _InvoiceBuilderState();
}

class _InvoiceBuilderState extends State<InvoiceBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              Icons.file_open,
              color: Colors.indigo,
              size: 35.00,
            ),
            WidthSpacer(myWidth: 5.5),
            Text(
              "Invoice",
              style: TextStyle(fontSize: 23.00, fontWeight: FontWeight.bold),
            )
          ],
        ),

        const HeightSpacer(myHeight: 10.00),
        Container(
          color: const Color.fromARGB(255, 189, 255, 191),
          width: double.infinity,
          height: 36.00,
          child: const Center(
            child: Text(
              "Approvals",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 107, 4),
                  fontSize: 20.00,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),

        for (var i = 0; i < 7; i++) buildTableData(i, widget.id, widget.orderDate, widget.paymentMethod, widget.deliveryDate, widget.address, widget.price),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            color: const Color.fromARGB(255, 255, 251, 251),
            width: double.infinity,
            height: 36.00,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "\$ 23.50",
                  style: TextStyle(
                    fontSize: 22.00,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 107, 4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTableData(int i, String id, String orderDate, String paymentMethod, String deliveryDate, String address, String price) {
    List<String> columnTitles = [
      "Id",
      "OrderDate",
      "PaymentMethod",
      "DeliveryDate",
      "Address",
      "Price"
    ];

    List<String> columnData = [
      id,
      orderDate,
      paymentMethod,
      deliveryDate,
      address,
      price,
    ];

    return Container(
      width: double.infinity,
      height: 36.00,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            i == 6
                ? Expanded(
                  child: const Text("Tax",
                                style: TextStyle(fontSize: 18.00, fontWeight: FontWeight.bold),),
                )
                : Expanded(
                  child: Text(columnTitles[i].toString(), style: const TextStyle(
                  fontSize: 18.00, fontWeight: FontWeight.bold), maxLines: 1,),
                ),
            i == 6
                ? Expanded(
                  child: const Text("\$ 2.50",
                                style: TextStyle(fontSize: 18.00, fontWeight: FontWeight.normal),),
                )
                : Expanded(
                  child: Text(columnData[i].toString(), style: const TextStyle(
                  fontSize: 18.00, fontWeight: FontWeight.normal), maxLines: 1,),
                ),
          ],
        ),
      ),
    );
  }
}