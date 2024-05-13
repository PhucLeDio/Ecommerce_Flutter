import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/brands/brand_show_case.dart';
import 'package:flutter_ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:flutter_ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:flutter_ecommerce/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:flutter_ecommerce/common/widgets/texts/section_heading.dart';
import 'package:flutter_ecommerce/features/shop/controllers/category_controller.dart';
import 'package:flutter_ecommerce/features/shop/models/category_model.dart';
import 'package:flutter_ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:flutter_ecommerce/features/shop/screens/store/widgets/category_brands.dart';
import 'package:flutter_ecommerce/utils/constants/image_strings.dart';
import 'package:flutter_ecommerce/utils/constants/sizes.dart';
import 'package:flutter_ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/product/product_controller.dart';

class TCategorytab extends StatelessWidget {
  const TCategorytab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Brands
              CategoryBrands(category: category),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// -- Products
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {
                  final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: const TVerticalProductShimmer());
                  if (response != null) return response;

                  final products = snapshot.data!;

                  return Column(
                    children: [
                      TSectionHeading(title: 'You might like', onPressed: () => Get.to(AllProducts(
                        title: category.name,
                        futureMethod: controller.getCategoryProducts(categoryId: category.id, limit: -1),
                      ))),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      TGridLayout(itemCount: products.length, itemBuilder: (_, index) => TProductCardVertical(product: products[index])),
                    ],
                  );
                }
              ),
            ],
          ),
        ),
      ],
    );
  }
}