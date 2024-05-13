
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/chips/choice_chip.dart';
import 'package:flutter_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:flutter_ecommerce/common/widgets/texts/section_heading.dart';
import 'package:flutter_ecommerce/common/widgets/texts/t_product_price_text.dart';
import 'package:flutter_ecommerce/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
    children: [
      ///-- Selected Attribute Pricing & Description
      TRoudedContainer(
        padding: const EdgeInsets.all(TSizes.md),
        backgroundColor: dark ? TColors.darkerGrey: TColors.grey,
        child: Column(
          children: [
            /// Title, Price and Stock Staus
            Row(
              children: [
                const TSectionHeading(title: 'Variation', showActionButton: false),
                const SizedBox(width: TSizes.spaceBtwItems),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const TProductTitleText(title: 'Price: ',smallSize: true ),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        /// Actual Price
                        Text(
                          '\$5',
                          style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),

                        /// Sale Price
                        const TProductPriceText(price: '4')
                      ]
                    ),
                    /// Stock
                    Row(
                      children: [
                        const TProductTitleText(title: 'Stock: ', smallSize: true),
                        Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                  ],
                )
              ],
            ),
            /// Variation Description
            const TProductTitleText(
              title: 'This is the Description of the Product and it can go upto max 4 Lines.',
              smallSize: true,
              maxLines: 4,
            ),
          ],
        ),
      ),
      const SizedBox(height: TSizes.spaceBtwItems),

      ///-- Attributes
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const TSectionHeading(title: 'Colors', showActionButton: false),
          const SizedBox(height: TSizes.spaceBtwItems/2),
        Wrap(
          children: [
            TChoiceChip(text: 'Green', selected: false, onSelected: (value){}),
            TChoiceChip(text: 'White', selected: true, onSelected: (value){}),
            TChoiceChip(text: 'Black', selected: false, onSelected: (value){}),
          ],
        )
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TSectionHeading(title: 'Size',showActionButton: false),
          const SizedBox(height: TSizes.spaceBtwItems/2),
         Wrap(
           spacing: 8,
           children: [
             TChoiceChip(text: '43', selected: false, onSelected: (value){}),
             TChoiceChip(text: '44', selected: true, onSelected: (value){}),
             TChoiceChip(text: '45', selected: false, onSelected: (value){}),
           ],
         )
        ],
      )
    ],
    );
  }
}
