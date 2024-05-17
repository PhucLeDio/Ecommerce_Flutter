import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/personalization/screens/admin/widgets/add_new_brand.dart';
import 'package:flutter_ecommerce/features/personalization/screens/admin/widgets/product/add_new_product.dart';
import 'package:flutter_ecommerce/features/personalization/screens/admin/widgets/product/all_product_to_delete.dart';
import 'package:flutter_ecommerce/features/shop/screens/deliver/widget/map/view_map.dart';
import 'package:flutter_ecommerce/features/shop/screens/deliver/widget/printer/home_printer.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../shop/controllers/product/product_controller.dart';

class OrderOptionScreen extends StatelessWidget {
  const OrderOptionScreen(
      {super.key,
      required this.id,
      required this.orderDate,
      required this.paymentMethod,
      required this.deliveryDate,
      required this.address,
      required this.price});

  final String id;
  final String orderDate;
  final String paymentMethod;
  final String deliveryDate;
  final String address;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
          showBackArrow: true, title: Text("Order options panel")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  ///--Account setting
                  const TSectionHeading(
                      title: 'Choose your option', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                    icon: Iconsax.airplane,
                    title: 'Delivery Map',
                    subtitle: 'Set shopping products details',
                    onTap: () => Get.to(() => const ViewMap()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Print receipt',
                    subtitle: 'Set shopping products details',
                    onTap: () => Get.to(() => PrinterHomeScreen(
                          title: "Printer panel",
                          id: id,
                          orderDate: orderDate,
                          paymentMethod: paymentMethod,
                          deliveryDate: deliveryDate,
                          address: address,
                          price: price,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
