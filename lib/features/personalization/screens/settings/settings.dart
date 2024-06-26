import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter_ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:flutter_ecommerce/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:flutter_ecommerce/common/widgets/texts/section_heading.dart';
import 'package:flutter_ecommerce/data/dummy_data.dart';
import 'package:flutter_ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter_ecommerce/features/shop/controllers/product/paypal_controller.dart';
import 'package:flutter_ecommerce/features/shop/screens/assistant/chat_bot.dart';
import 'package:flutter_ecommerce/features/shop/screens/cart/cart.dart';
import 'package:flutter_ecommerce/features/shop/screens/order/order.dart';
import 'package:flutter_ecommerce/data/repositories/product/product_repository.dart';
import 'package:flutter_ecommerce/features/personalization/screens/address/address.dart';
import 'package:flutter_ecommerce/features/personalization/screens/admin/load_multiple_choice.dart';
import 'package:flutter_ecommerce/localization/map_screen.dart';
import 'package:flutter_ecommerce/localization/order_tracking_page.dart';
import 'package:flutter_ecommerce/features/shop/screens/deliver/widget/map/view_map.dart';
import 'package:flutter_ecommerce/utils/constants/colors.dart';
import 'package:flutter_ecommerce/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthenticationRepository.instance);
    final product = Get.put(ProductRepository.instance);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///--Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),

                  ///--user profile card
                  TUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            ///--Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  ///--Account setting
                  const TSectionHeading(
                      title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set shopping delivery address',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'Add, remove products and move to checkout ',
                    onTap: () =>Get.to(()=> const CartScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress and Completed Orders',
                    onTap: ()=> Get.to(()=> const OrderScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.user,
                    title: 'Chatbot panel',
                    subtitle: 'Ask us in every topics, every field ',
                    onTap: () => Get.to(() => const ViewChatBot()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subtitle: 'Withdraw balance to registered bank account ',
                    onTap: (){},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subtitle: 'List of all the discounted coupons',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subtitle: 'Set any kind of notification message',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subtitle: 'Manage data usage and connected accounts',
                    onTap: () {},
                  ),

                  ///--App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(
                      title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: 'Admin',
                      subtitle: 'Upload Data to your Cloud Firebase',
                      onTap: () => Get.to(() => const LoadMultipleChoice())),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subtitle: 'Set recommendation based on location',
                    trailing: Switch(value: false, onChanged: (value){}),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subtitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subtitle: 'Set image quality to be seen',
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  ///--Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: () => controller.logout(), child: const Text('Logout')),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections *2.5)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}