import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20reviews/widget/rating_progress_indicator.dart';
import 'package:flutter_ecommerce/features/shop/screens/product%20reviews/widget/user_review_card.dart';

import '../../../../common/widgets/products/ratings/rating_indicator.dart';
import '../../../../utils/constants/sizes.dart';


class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Appbar
      appBar: const TAppBar(title: Text('Reviews & Ratings'), showBackArrow: true),


      /// Body
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Ratings and reviews are verified and are from people who use the same type of device that you use."),
              const SizedBox(height: TSizes.spaceBtwItems,),

              /// Overall product ratings
              const TOverallProductRating(),
              const TRatingBarIndicator(rating: 4.8),
              Text('14,054', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// User Review List

              const UserReviewCard(),
              const UserReviewCard(),

            ],
          ),

        ),

      ),
    );
  }
}













