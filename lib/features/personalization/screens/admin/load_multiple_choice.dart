import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/personalization/screens/admin/crud_product.dart';
import 'package:flutter_ecommerce/features/personalization/screens/admin/widgets/add_new_brand.dart';
import 'package:flutter_ecommerce/features/personalization/screens/admin/widgets/product/add_new_product.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';

class LoadMultipleChoice extends StatelessWidget {
  const LoadMultipleChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text("Admin Panel")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  ///--Account setting
                  const TSectionHeading(
                      title: 'Upload your data', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                    icon: Iconsax.shop,
                    title: 'Products',
                    subtitle: 'Set shopping products details',
                    onTap: () => Get.to(() => const CrudProductScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Brands',
                    subtitle: 'Set shopping products details',
                    onTap: () => Get.to(() => const AddNewBrand()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Categories',
                    subtitle: 'Set shopping products details',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'Banners',
                    subtitle: 'Set shopping products details',
                    onTap: (){},
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