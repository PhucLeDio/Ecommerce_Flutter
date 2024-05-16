import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/shop/controllers/product/product_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';

class AddNewProduct extends StatelessWidget {
  const AddNewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text("Add new product")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.productFormKey,
            child: Column(
              children: [
                TextFormField(controller: controller.productName, validator: (value) => TValidator.validateEmptyText('Product name', value), decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: "Product name")),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(controller: controller.description, validator: (value) => TValidator.validateEmptyText('Description', value), decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: "Description")),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(child: TextFormField(controller: controller.brand, validator: (value) => TValidator.validateEmptyText('Brand', value), decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: "Brand"))),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(child: TextFormField(controller: controller.price, validator: (value) => TValidator.validateEmptyText('Price', value), decoration: const InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: "Price"))),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(child: TextFormField(controller: controller.salePrice, validator: (value) => TValidator.validateEmptyText('Sale Price', value), expands: false, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: "Sale Price"))),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(child: TextFormField(controller: controller.stock, validator: (value) => TValidator.validateEmptyText('Stock', value), expands: false, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: "Stock"))),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(controller: controller.title, validator: (value) => TValidator.validateEmptyText('Title', value), decoration: const InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: "Title")),
                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.addNewProducts,
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),// Positions the FAB in the bottom right corner
    );
  }
}