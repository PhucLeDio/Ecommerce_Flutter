import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:flutter_ecommerce/common/widgets/shimmers/shimmer.dart';

class TBrandsShimmer extends StatelessWidget {
  const TBrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const TShimmerEffect(width: 300, height: 80),
    );
  }
}
