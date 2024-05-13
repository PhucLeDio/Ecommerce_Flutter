import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/shimmers/shimmer.dart';
import 'package:flutter_ecommerce/utils/constants/sizes.dart';

class TListTileShimmer extends StatelessWidget {
  const TListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            TShimmerEffect(width: 50, height: 50, radius: 50),
            SizedBox(height: TSizes.spaceBtwItems),
            Column(
              children: [
                TShimmerEffect(width: 100, height: 15),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                TShimmerEffect(width: 80, height: 12),
              ],
            ),
          ],
        ),
      ],
    );
  }
}