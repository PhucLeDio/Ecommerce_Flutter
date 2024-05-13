import 'package:flutter/material.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      TSectionHeading(title: 'Address',buttonTitle: 'Change', onPressed: (){},),
     Text('Phan Nguyen Huy Hoang', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: TSizes.spaceBtwItems/2),
        Row(
          children: [
            const Icon(Icons.phone, color: Colors.grey,size: 16,),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text('0935478396', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems/2),
        Row(
          children: [
            const Icon(Icons.location_history, color: Colors.grey,size: 16,),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(child: Text('Son Tra, Da Nang, Viet Nam', style: Theme.of(context).textTheme.bodyMedium, softWrap: true)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems/2),
    ],
    );
  }
}
