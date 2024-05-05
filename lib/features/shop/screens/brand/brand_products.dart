import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter_ecommerce/common/widgets/brands/t_brand_card.dart';
import 'package:flutter_ecommerce/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:flutter_ecommerce/features/shop/controllers/all_products_controller.dart';
import 'package:flutter_ecommerce/features/shop/controllers/brand_controller.dart';
import 'package:flutter_ecommerce/features/shop/models/brand_model.dart';
import 'package:flutter_ecommerce/features/shop/screens/sort/sortable_products.dart';
import 'package:flutter_ecommerce/utils/constants/sizes.dart';
import 'package:get/get.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(title: Text(brand.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand detail
              TBrandCard(showBorder: true, brand: brand),
              const SizedBox(height: TSizes.spaceBtwSections),

              FutureBuilder(
                future: controller.getBrandProducts(brandId: brand.id),
                builder: (context, snapshot) {
                  const loader = TVerticalProductShimmer();
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Data Found'));
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  }

                  final brandProducts = snapshot.data!;
                  return TSortableProducts(products: brandProducts);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}