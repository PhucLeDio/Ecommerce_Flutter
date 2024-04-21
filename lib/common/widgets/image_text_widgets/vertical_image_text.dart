import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/images/t_circular_image.dart';
import 'package:flutter_ecommerce/utils/constants/colors.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = TColors.white,
    this.backgroundColor,
    this.onTap,
    this.isNetWorkImage = true,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetWorkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Circular icon
            TCircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: TSizes.sm * 1.4,
              isNetworkImage: isNetWorkImage,
              backgroundColor: backgroundColor,
              overlayColor: dark ? TColors.light : TColors.dark,
            ),

            /// Text
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            SizedBox(width: 55, child: Center(child: Text(title, style: Theme.of(context).textTheme.labelMedium!.apply(color: textColor), maxLines: 1, overflow: TextOverflow.ellipsis)))
          ],
        ),
      ),
    );
  }
}