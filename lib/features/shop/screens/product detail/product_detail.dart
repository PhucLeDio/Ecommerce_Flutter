import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/texts/section_heading.dart';
import 'package:flutter_ecommerce/features/shop/models/product_model.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/product_attributes.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/product_detail_image_slider.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/product_meta_data.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/rating_share_widget.dart';
import 'package:flutter_ecommerce/utils/constants/colors.dart';
import 'package:flutter_ecommerce/utils/constants/enums.dart';
import 'package:flutter_ecommerce/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import '../../../../utils/constants/sizes.dart';
import '../product reviews/product_reviews.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});
  final bool _isLiked = false;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
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
              TextButton.icon(
                onPressed: () {
                  // You can't use setState in a StatelessWidget,
                  // you need to use a Stateful widget or a state management solution like Provider or Getx
                  // setState(() {
                  //   _isLiked =!_isLiked;
                  // });
                },
                icon: Icon(
                  _isLiked
                      ? Iconsax.heart5
                      : Iconsax.heart5,
                  color: _isLiked
                      ? Colors.red
                      : null,
                ),
                label: Text('Add to WishList'),
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Iconsax.shopping_bag),
                  label: Text('Add to Cart')),
            ],
          ),
        ),
      ),
    );
  }
}