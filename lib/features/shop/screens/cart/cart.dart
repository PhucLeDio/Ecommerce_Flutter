import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter_ecommerce/common/widgets/loaders/animation_loader.dart';
import 'package:flutter_ecommerce/features/shop/controllers/product/cart_controller.dart';
import 'package:flutter_ecommerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:flutter_ecommerce/features/shop/screens/purchase/purchase.dart';
import 'package:flutter_ecommerce/navigation_menu.dart';
import 'package:flutter_ecommerce/utils/constants/image_strings.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title:
              Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: Obx(() {
        final emptyWidget = TAnimationLoaderWidget(
          text: 'Cart is empty!',
          animation: TImages.pencilAnimation,
          showAction: true,
          actionText: 'Let\'s fill it',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: TCartItems(),
            ),
          );
        }
      }),
      bottomNavigationBar: controller.cartItems.isEmpty ? const SizedBox() : Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(() => const PurchaseScreen()),
            child: Obx(
                () => Text('Purchase \$${controller.totalCartPrice.value}'))),
      ),
    );
  }
}
