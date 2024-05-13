import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/shop/controllers/brand_controller.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';

class AddNewBrand extends StatelessWidget {
  const AddNewBrand({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text("Add new category")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.brandFormKey,
            child: Column(
              children: [
                TextFormField(controller: controller.brandId, validator: (value) => TValidator.validateEmptyText('Brand ID', value), decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: "Brand ID")),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(controller: controller.brandName, validator: (value) => TValidator.validateEmptyText('Brand name', value), decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: "Brand name")),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: "Is Featured")),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(controller: controller.productCounts, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: "Products count")),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextButton(onPressed: controller.uploadBrandPicture, child: const Text('Upload Brand Picture')),
                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.addNewBrands,
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ), // Positions the FAB in the bottom right corner
    );
  }
}