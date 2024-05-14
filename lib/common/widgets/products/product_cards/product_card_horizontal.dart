import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_ecommerce/common/widgets/icons/t_circular_icon.dart';
import 'package:flutter_ecommerce/common/widgets/images/t_rounded_image.dart';
import 'package:flutter_ecommerce/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:flutter_ecommerce/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:flutter_ecommerce/common/widgets/texts/t_product_price_text.dart';
import 'package:flutter_ecommerce/features/shop/models/product_model.dart';
import 'package:flutter_ecommerce/utils/constants/colors.dart';
import 'package:flutter_ecommerce/utils/enums/enums.dart';
import 'package:flutter_ecommerce/utils/constants/image_strings.dart';
import 'package:flutter_ecommerce/utils/constants/sizes.dart';
import 'package:flutter_ecommerce/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../texts/product_title_text.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
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
                SizedBox(
                  height: 120,
                  width: 120,
                  child: TRoundedImage(imageUrl: product.thumbnail, applyImageRadius: true, isNetworkImage: true,),
                ),

                /// Sale tag
                if (salePercentage != null)
                  Positioned(
                    top: 12,
                    child: TRoudedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text('$salePercentage%', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black)),
                    ),
                  ),

                /// Favourite icon button
                Positioned(
                    top: 0,
                    right: 0,
                    child: TFavouriteIcon(productId: product.id,),
                ),
              ],
            ),
          ),

          /// Details, add to cart, pricing
          SizedBox(
            width: 172,
            child: Padding(
              padding: EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductTitleText(title: product.title, smallSize: true,),
                      SizedBox(height: TSizes.spaceBtwItems / 2),
                      TBrandTitleWithVerifiedIcon(title: product.brand!.name),
                    ],
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// pricing
                      Flexible(child: Column(
                        children: [
                          if (product.productType == ProductType.single.toString() && product.salePrice > 0)
                            Padding(
                              padding: const EdgeInsets.only(left: TSizes.sm),
                              child: Text(
                                product.price.toString(),
                                style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                              ),
                            ),

                          /// Price, show sale price
                          Padding(
                            padding: const EdgeInsets.only(left: TSizes.sm),
                            child: TProductPriceText(price: controller.getProductPrice(product)),
                          ),
                        ],
                      )),

                      /// add to cart
                      Container(
                        decoration: const BoxDecoration(
                          color: TColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(TSizes.cardRadiusMd),
                            bottomRight: Radius.circular(TSizes.productImageRadius),
                          ),
                        ),
                        child: const SizedBox(
                            width: TSizes.iconLg * 1.2,
                            height: TSizes.iconLg * 1.2,
                            child: Center(child: Icon(Iconsax.add, color: TColors.white))
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}