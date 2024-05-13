import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/success_screen/success_screen.dart';
import 'package:flutter_ecommerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:flutter_ecommerce/features/shop/screens/purchase/widgets/billing_address_section.dart';
import 'package:flutter_ecommerce/features/shop/screens/purchase/widgets/billing_amount_section.dart';
import 'package:flutter_ecommerce/features/shop/screens/purchase/widgets/billing_payment_section.dart';
import 'package:flutter_ecommerce/navigation_menu.dart';
import 'package:flutter_ecommerce/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(showBackArrow: true,title:  Text('Order Review', style: Theme.of(context).textTheme.headlineSmall )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Items in Cart
              const TCartItems(showAddRemoveButtons: false,),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Coupon TextField
             const TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Billing
              TRoudedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black: TColors.white,
                child: const Column(
                  children: [
                    ///Pricing
                    TBillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems,),

                    ///Divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    ///Payment Methods
                    TBillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    ///Address
                    TBillingAddressSection(),
                    SizedBox(height: TSizes.spaceBtwItems),
                  ],
                ),
              )
            ],
          ),
        ),
      ),


      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: ()=> Get.to(()=>SuccessScreen(
              image: TImages.successfullyRegisterAnimation,
              title: 'Payment Success!',
              subTitle: 'Your item will be shipped soon!',
              onPressed: ()=>Get.offAll(()=> const NavigationMenu()),
        ),
        ),
            child: const Text('Purchase \$140')),
      ),
    );
  }
}





