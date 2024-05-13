import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter_ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:flutter_ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:flutter_ecommerce/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:flutter_ecommerce/features/shop/models/product_model.dart';
import 'package:flutter_ecommerce/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controllers/all_products_controller.dart';
import '../../controllers/product/product_controller.dart';
import '../sort/sortable_products.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key,
    required this.title,
    this.query,
    this.futureMethod
  });

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());

    return Scaffold(
      appBar:
          TAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {
              const loader = TVerticalProductShimmer();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loader;
              }

              if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data found'));
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong!'));
              }

              final products = snapshot.data!;

              return TSortableProducts(products: products);
            }
          ),
        ),
      ),
    );
  }
}
