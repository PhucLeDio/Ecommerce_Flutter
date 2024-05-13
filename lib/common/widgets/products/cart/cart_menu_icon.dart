import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/shop/screens/cart/cart.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key, required this.onPressed, this.iconColor, this.counterBgColor, this.counterTextColor,
  });

  final VoidCallback onPressed;
  final Color? iconColor, counterBgColor, counterTextColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: () => Get.to(() => const CartScreen()), icon: Icon(Icons.shopping_bag, color: iconColor,)),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
                color: TColors.black,
                borderRadius: BorderRadius.circular(100)
            ),
            child: Center(
              child: Text('2', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white, fontSizeFactor: 0.8)),
            ),
          ),
        )
      ],
    );
  }
}
