import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_ecommerce/common/widgets/loaders/animation_loader.dart';
import 'package:flutter_ecommerce/features/shop/controllers/product/order_controller.dart';
import 'package:flutter_ecommerce/navigation_menu.dart';
import 'package:flutter_ecommerce/utils/constants/image_strings.dart';
import 'package:flutter_ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter_ecommerce/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = THelperFunctions.isDarkMode(context);
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (context, snapshot) {
          final emptyWidget = TAnimationLoaderWidget(
            text: 'Oops! no order yet!',
            animation: TImages.pencilAnimation,
            showAction: true,
            actionText: 'Let\' fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );

          final response = TCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);
          if (response != null) return response;

          final orders = snapshot.data!;

          return ListView.separated(
              shrinkWrap: true,
              itemCount: orders.length,
              separatorBuilder: (_, __) =>
                  SizedBox(height: TSizes.spaceBtwItems),
              itemBuilder: (_, index) {
                final order = orders[index];
                return TRoudedContainer(
                  showBorder: true,
                  padding: const EdgeInsets.all(TSizes.md),
                  backgroundColor: dark ? TColors.dark : TColors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Row 1
                      Row(
                        children: [
                          /// Icon
                          Icon(Iconsax.ship),
                          SizedBox(width: TSizes.spaceBtwItems / 2),

                          /// Status & Date
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(order.orderStatusText,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .apply(
                                            color: TColors.primary,
                                            fontWeightDelta: 1)),
                                Text(order.formattedOrderDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                              ],
                            ),
                          ),
                          IconButton(
                              icon: Icon(Iconsax.arrow_right_34,
                                  size: TSizes.iconSm),
                              onPressed: () {}),
                        ],
                      ),
                      SizedBox(height: TSizes.spaceBtwItems),

                      /// bottom row
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                /// Icon
                                Icon(Iconsax.tag),
                                SizedBox(width: TSizes.spaceBtwItems / 2),

                                /// Order
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Order', maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelMedium,),
                                      Text(order.id, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Row(
                              children: [
                                Icon(Iconsax.calendar),
                                SizedBox(width: TSizes.spaceBtwItems / 2),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Shipping Date',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                    Text(order.formattedDeliveryDate,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
