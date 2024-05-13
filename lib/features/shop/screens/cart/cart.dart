import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter_ecommerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:flutter_ecommerce/features/shop/screens/purchase/purchase.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true,title:  Text('Cart', style: Theme.of(context).textTheme.headlineSmall )),
      body:  const Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: TCartItems(),
        ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(onPressed: ()=> Get.to(()=>const PurchaseScreen()), child: const Text('Purchase \$140')),
      ),

    );
  }
}






