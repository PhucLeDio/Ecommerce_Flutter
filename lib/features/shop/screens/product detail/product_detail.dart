import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/texts/section_heading.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/product_attributes.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/product_detail_image_slider.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/product_meta_data.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/rating_share_widget.dart';
import 'package:flutter_ecommerce/utils/constants/colors.dart';
import 'package:flutter_ecommerce/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import '../../../../utils/constants/sizes.dart';
import '../product reviews/product_reviews.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool _isLiked = false;



  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
          ///--product image slider
        const TProductImageSlider(),



          ///--product detail
        Padding(
            padding: const EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
          child: Column(
            children: [
              ///--rating and share button
              const TRatingAndShare(),

              ///--price,title,stock and brand
              const TProductMetaData(),

              ///--attributes
              const TProductAttributes(),
              const SizedBox(height: TSizes.spaceBtwSections,),

              ///--buy now button
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){},child: const Text('Purchase'))),
              const SizedBox(height: TSizes.spaceBtwSections,),

              ///--description
              const TSectionHeading(title: 'Description',showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems,),
              const ReadMoreText('Quicker than 1, 2, 3—the original hoops shoe lets you get going. This version of the AF-1 features Nike EasyOn technology for a hands-free experience. The flexible heel collapses when you step in then snaps back into place, making it easy to slip the shoe on and off. Add that to its clean, crisp leather and you have got ultimate wearability. Yeah, it is everything you love and then some.',
              trimLines: 2,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Less',
                moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w800),
              ),


              ///--reviews
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TSectionHeading(title: 'Reviews (199)', showActionButton: false),
                  IconButton( icon: const Icon(Iconsax.arrow_right_3,size: 18,), onPressed: ()=> Get.to(()=> const ProductReviewsScreen())),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections,),
            ],
          ),
        )
          ]
        ),
      ),
        ///--add to cart bottom bar
        bottomNavigationBar: BottomAppBar(
    child: Container(
      padding: const EdgeInsets. symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
         color: dark ? TColors.darkerGrey: TColors.light,
          borderRadius: const BorderRadius.only(
          topLeft: Radius. circular(TSizes.cardRadiusLg), topRight: Radius. circular(TSizes.cardRadiusLg),
    )),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:[
      TextButton.icon(
        onPressed: () {
          setState(() {
            _isLiked = !_isLiked; // Đảo ngược trạng thái khi nhấn vào
          });
        },
        icon: Icon(
          _isLiked ? Iconsax.heart5 : Iconsax.heart5, // Chuyển icon sang filled khi được nhấn
          color: _isLiked ? Colors.red : null, // Chuyển màu thành đỏ khi được nhấn
        ),
        label: const Text('Add to WishList'),
      ),

    const SizedBox(width: TSizes.spaceBtwItems,),

      TextButton.icon(onPressed: (){}, icon: const Icon(Iconsax.shopping_bag), label: const Text('Add to Bag')),

    ],
    ),
    ),
    ),
        );
  }
}




