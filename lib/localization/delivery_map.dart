import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utils/constants/colors.dart';

class DeliveryMap extends StatelessWidget {
  const DeliveryMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primary,
        title: Text("Delivery Map"),
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("View Map"),
        ),
      ),
    );
  }
}