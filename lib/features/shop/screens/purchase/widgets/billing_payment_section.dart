import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_ecommerce/common/widgets/texts/section_heading.dart';
import 'package:flutter_ecommerce/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TSectionHeading(title: 'Payment Method',buttonTitle: 'Change', onPressed: (){},),
        const SizedBox(height: TSizes.spaceBtwItems/2,),
        Row(
          children: [
            TRoudedContainer(
              height: 35,
              width: 60,
              backgroundColor: dark ? TColors.light: TColors.white,
              padding: const EdgeInsets.all(TSizes.sm),
              child: const Image(image: AssetImage(TImages.paypal), fit: BoxFit.contain),
            ),
            const SizedBox(width: TSizes.spaceBtwItems/2),
            Text('Paypal', style: Theme.of(context).textTheme.bodyLarge,)
          ],
        ),
      ],
    );
  }
}
