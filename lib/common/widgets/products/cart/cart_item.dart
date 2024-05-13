import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/t_rounded_image.dart';
import '../../texts/product_title_text.dart';
import '../../texts/t_brand_title_text_with_verified_icon.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        TRoundedImage(
            imageUrl: TImages.productImage1,
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkerGrey: TColors.light
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        /// Title, Price and Size
        Expanded(
            child:  Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TBrandTitleWithVerifiedIcon(title: 'Nike'),
                const Flexible(child: TProductTitleText(title: 'Nike Air Force 1',maxLines: 1,)),
                /// Attribute
                Text.rich(
                    TextSpan(
                        children: [
                          TextSpan(text: 'Color ', style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(text: 'White ',style: Theme.of(context).textTheme.bodyLarge),
                          TextSpan(text: 'Size ', style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(text: '44',style: Theme.of(context).textTheme.bodyLarge),

                        ]
                    )
                ),
              ],
            )
        ),

      ],
    );
  }
}