import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter_ecommerce/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:flutter_ecommerce/common/widgets/images/t_rounded_image.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/product_attributes.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/product_detail_image_slider.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/product_meta_data.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20detail/widgets/rating_share_widget.dart';
import 'package:flutter_ecommerce/utils/constants/colors.dart';
import 'package:flutter_ecommerce/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    final dark = THelperFunctions.isDarkMode(context);
    void incrementQuantity() {
      if(
        quantity++;
      )};
    }
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
            ],
          ),
        )



          ///--add to cart bottom bar



          ]
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      IconButton(
      icon: Icon(Icons.remove),
      onPressed: (){},
    ),
          Text(
            '$quantity',
            style: TextStyle(fontSize: 20.0),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){},
          ),
        TextButton(
          onPressed: () {
            // Thực hiện hành động khi nhấn vào button
          },
          child: Row(
            children: [
              Icon(Icons.shopping_bag,color: Colors.black,),
              SizedBox(width: TSizes.spaceBtwItems), // Khoảng cách giữa icon và text
              Text('Add to Cart',style: TextStyle(color: Colors.black)),
        ],
      ),
          ),
    ],
    ),
      ),
      ),
    );
  }
}



