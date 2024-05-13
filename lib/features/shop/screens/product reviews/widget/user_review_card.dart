import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_ecommerce/common/widgets/products/ratings/rating_indicator.dart';
import 'package:flutter_ecommerce/utils/helpers/helper_functions.dart';
import 'package:readmore/readmore.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: AssetImage(TImages.user)),
                const SizedBox(width: TSizes.spaceBtwItems,),
                Text('King Phan', style: Theme.of(context).textTheme.titleLarge,)
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Review

        Row(
          children: [
            const TRatingBarIndicator(rating: 4),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text('14 May, 2024', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        const ReadMoreText(
            'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimExpandedText: 'Show Less',
          trimCollapsedText: 'Show More',
            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
            lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Company Review

        TRoudedContainer(
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
           child: Column(
    children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Nike Store', style: Theme.of(context).textTheme.titleMedium),
        Text('14 May, 2024',style: Theme.of(context).textTheme.bodyMedium),

    ],
      ),
      const SizedBox(height: TSizes.spaceBtwItems),
      const ReadMoreText(
        'Thanks for your review and rating!',
        trimLines: 1,
        trimMode: TrimMode.Line,
        trimExpandedText: 'Show Less',
        trimCollapsedText: 'Show More',
        moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
        lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
      ),
    ],
    ),

        ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}


