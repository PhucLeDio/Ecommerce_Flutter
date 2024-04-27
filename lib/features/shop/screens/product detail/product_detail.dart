import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter_ecommerce/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:flutter_ecommerce/common/widgets/images/t_rounded_image.dart';
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
import '../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

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
              TRatingAndShare(),

              ///--price,title,stock and brand
              TProductMetaData(),

              ///--attributes
              TProductAttributes(),
              SizedBox(height: TSizes.spaceBtwSections,),

              ///--buy now button
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){},child: Text('Buy Now'))),
              SizedBox(height: TSizes.spaceBtwSections,),

              ///--description
              TSectionHeading(title: 'Description',showActionButton: false),
              SizedBox(height: TSizes.spaceBtwItems,),
              ReadMoreText('Quicker than 1, 2, 3—the original hoops shoe lets you get going. This version of the AF-1 features Nike EasyOn technology for a hands-free experience. The flexible heel collapses when you step in then snaps back into place, making it easy to slip the shoe on and off. Add that to its clean, crisp leather and you have got ultimate wearability. Yeah, it is everything you love and then some.',
              trimLines: 2,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Less',
                moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w800),
              ),


              ///--reviews
              Divider(),
              SizedBox(height: TSizes.spaceBtwItems,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TSectionHeading(title: 'Reviews (199)', showActionButton: false),
                  IconButton( icon: Icon(Iconsax.arrow_right_3,size: 18,), onPressed: (){}),
                ],
              ),
              SizedBox(height: TSizes.spaceBtwSections,),
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
        label: Text('Add to WishList'),
      ),

    SizedBox(width: TSizes.spaceBtwItems,),

      TextButton.icon(onPressed: (){}, icon: Icon(Iconsax.shopping_bag), label: Text('Add to Bag')),

    ],
    ),
    ),
    ),
        );
  }
}




