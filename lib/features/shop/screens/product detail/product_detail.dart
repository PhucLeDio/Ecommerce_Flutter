import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/icons/t_circular_icon.dart';
import 'package:flutter_ecommerce/common/widgets/texts/section_heading.dart';
import 'package:flutter_ecommerce/features/shop/models/product_model.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/product_attributes.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/product_detail_image_slider.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/product_meta_data.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/rating_share_widget.dart';
import 'package:flutter_ecommerce/utils/constants/colors.dart';
import 'package:flutter_ecommerce/utils/enums/enums.dart';
import 'package:flutter_ecommerce/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/cart_controller.dart';
import '../product reviews/product_reviews.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});
  final bool _isLiked = false;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    cartController.updateAlreadyAddedProductCount(product);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          ///--product image slider
          TProductImageSlider(product: product),

          ///--product detail
          Padding(
            padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace),
            child: Column(
              children: [
                ///--rating and share button
                TRatingAndShare(),

                ///--price,title,stock and brand
                TProductMetaData(product: product),

                ///--attributes
                if (product.productType == ProductType.variable.toString()) TProductAttributes(product: product),
                if (product.productType == ProductType.variable.toString()) const SizedBox(height: TSizes.spaceBtwSections,),

                ///--buy now button
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: Text('Buy Now'))),
                SizedBox(height: TSizes.spaceBtwSections,),

                ///--description
                TSectionHeading(title: 'Description', showActionButton: false),
                SizedBox(height: TSizes.spaceBtwItems),
                ReadMoreText(
                  product.description ?? '',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Less',
                  moreStyle:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  lessStyle:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),

                ///--reviews
                Divider(),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TSectionHeading(
                        title: 'Reviews (199)', showActionButton: false),
                    IconButton(
                        icon: Icon(
                          Iconsax.arrow_right_3,
                          size: 18,
                        ),
                        onPressed: () => Get.to(()=> const ProductReviewsScreen())),
                  ],
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            ),
          )
        ]),
      ),

      ///--add to cart bottom bar
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: TSizes.defaultSpace,
              vertical: TSizes.defaultSpace / 2),
          decoration: BoxDecoration(
              color: dark? TColors.darkerGrey : TColors.light,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(TSizes.cardRadiusLg),
                topRight: Radius.circular(TSizes.cardRadiusLg),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                    () => Row(
                  children: [
                    TCircularIcon(
                      icon: Iconsax.minus,
                      backgroundColor: TColors.darkGrey,
                      width: 40,
                      height: 40,
                      color: TColors.white,
                      onPressed: () => cartController.productQuantityInCart.value < 1 ? null : cartController.productQuantityInCart.value -= 1,
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems,),
                    Text(cartController.productQuantityInCart.value.toString(), style: Theme.of(context).textTheme.titleSmall,),
                    const SizedBox(width: TSizes.spaceBtwItems,),
                    TCircularIcon(
                      icon: Iconsax.add,
                      backgroundColor: TColors.black,
                      width: 40,
                      height: 40,
                      color: TColors.white,
                      onPressed: () => cartController.productQuantityInCart.value += 1,
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: () => cartController.addToCart(product),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(TSizes.md),
                  backgroundColor: TColors.grey,
                  side: const BorderSide(color: TColors.black),
                ),
                child: const Text('Add to cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}