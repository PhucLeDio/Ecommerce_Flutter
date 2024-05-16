import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/personalization/screens/admin/widgets/product/t_product_card_delete_vertical.dart';
import 'package:flutter_ecommerce/features/shop/controllers/all_products_controller.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../shop/models/product_model.dart';

class TSortableDeleteProducts extends StatelessWidget {
  const TSortableDeleteProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        /// Drop down
        DropdownButtonFormField(
            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
            value: controller.selectedSortOption.value,
            onChanged: (value) {
              controller.sortProducts(value!);
            },
            items: [
              'Name',
              'Higher price',
              'Lower price',
              'Sale',
              'Newest',
              'Popularity'
            ]
                .map((option) =>
                DropdownMenuItem(value: option, child: Text(option)))
                .toList()),
        const SizedBox(height: TSizes.spaceBtwSections),

        /// Products
        Obx(
              () => TGridLayout(
              itemCount: controller.products.length,
              itemBuilder: (_, index) =>
                  TProductCardDeleteVertical(product: controller.products[index])),
        ),
      ],
    );
  }
}
