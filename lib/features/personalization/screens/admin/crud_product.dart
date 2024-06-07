import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/personalization/screens/admin/widgets/add_new_brand.dart';
import 'package:flutter_ecommerce/features/personalization/screens/admin/widgets/product/add_new_product.dart';
import 'package:flutter_ecommerce/features/personalization/screens/admin/widgets/product/all_product_to_delete.dart';
import 'package:flutter_ecommerce/features/personalization/screens/admin/widgets/product/all_product_to_upload_image.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../shop/controllers/product/product_controller.dart';

class CrudProductScreen extends StatelessWidget {
  const CrudProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text("CRUD product Panel")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  ///--Account setting
                  const TSectionHeading(
                      title: 'CRUD your product data', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                    icon: Iconsax.shop,
                    title: 'Create Products',
                    subtitle: 'Set shopping products details',
                    onTap: () => Get.to(() => const AddNewProduct()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Upload image',
                    subtitle: 'Set shopping products details',
                    onTap: () => Get.to(() => AllProductsUploadImage(title: 'Upload image product', futureMethod: controller.fetchAllFeaturedProducts(),)),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Delete product',
                    subtitle: 'Set shopping products details',
                    onTap: () => Get.to(() => AllProductsDelete(title: 'Delete product', futureMethod: controller.fetchAllFeaturedProducts(),)),
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