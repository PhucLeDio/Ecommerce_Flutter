import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_ecommerce/common/widgets/icons/t_circular_icon.dart';
import 'package:flutter_ecommerce/common/widgets/images/t_rounded_image.dart';
import 'package:flutter_ecommerce/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:flutter_ecommerce/utils/constants/colors.dart';
import 'package:flutter_ecommerce/utils/constants/image_strings.dart';
import 'package:flutter_ecommerce/utils/constants/sizes.dart';
import 'package:flutter_ecommerce/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: THelperFunctions.isDarkMode(context) ? TColors.darkerGrey : TColors.softGrey,
      ),
      child: Row(
        children: [
          /// Thumbnail
          TRoudedContainer(
            height: 120,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.dark : Colors.white,
            child: Stack(
              children: [
                /// Thumb image
                const SizedBox(
                  height: 120,
                  width: 120,
                  child: TRoundedImage(imageUrl: TImages.productImage1, applyImageRadius: true),
                ),

                /// Sale tag
                Positioned(
                  top: 12,
                  child: TRoudedContainer(
                    radius: TSizes.sm,
                    backgroundColor: TColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                    child: Text('25%', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black)),
                  ),
                ),

                /// Favourite icon button
                const Positioned(
                    top: 0,
                    right: 0,
                    child: TFavouriteIcon(productId: '',),
                ),
              ],
            ),
          ),

          /// Details, add to cart, pricing

        ],
      ),
    );
  }
}