import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_ecommerce/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (_,__)=> SizedBox(height: TSizes.spaceBtwItems),
      itemBuilder: (_,index)=> TRoudedContainer(
        showBorder: true,
        padding: EdgeInsets.all(TSizes.sm),
        backgroundColor: dark ? TColors.dark: TColors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Row 1
            Row(
              children: [
                /// Icon
                Icon(Iconsax.ship),
                SizedBox(width: TSizes.spaceBtwItems/2),

                /// Status & Date
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                              Text('Processing', style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary, fontWeightDelta: 1)),
                                                Text('14 May, 2024', style: Theme.of(context).textTheme.headlineSmall),
                            ],
                          ),
                ),
                    IconButton( icon: Icon(Iconsax.arrow_right_34, size: TSizes.iconSm), onPressed: (){}),
                      ],
                    ),
            SizedBox(height: TSizes.spaceBtwItems),
            /// Row 2
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      /// Icon
                      Icon(Iconsax.tag),
                      SizedBox(width: TSizes.spaceBtwItems/2),

                      /// Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order', style: Theme.of(context).textTheme.labelMedium),
                          Text('[#256f2]', style: Theme.of(context).textTheme.titleMedium),
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
                      SizedBox(width: TSizes.spaceBtwItems/2),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Shipping Date', style: Theme.of(context).textTheme.labelMedium),
                          Text('24 May, 2024', style: Theme.of(context).textTheme.titleMedium),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
                  ],
                ),
            ),
    );
  }
}
