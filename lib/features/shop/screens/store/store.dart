import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter_ecommerce/common/widgets/appbar/tabbar.dart';
import 'package:flutter_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_ecommerce/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:flutter_ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:flutter_ecommerce/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:flutter_ecommerce/common/widgets/texts/section_heading.dart';
import 'package:flutter_ecommerce/features/shop/screens/store/widgets/category_tab.dart';
import 'package:flutter_ecommerce/utils/constants/colors.dart';
import 'package:flutter_ecommerce/utils/constants/image_strings.dart';
import 'package:flutter_ecommerce/utils/constants/sizes.dart';
import 'package:flutter_ecommerce/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/brands/brand_show_case.dart';
import '../../../../common/widgets/brands/t_brand_card.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TCartCounterIcon(onPressed: (){}, iconColor: TColors.black)
          ],
        ),
        body: NestedScrollView(headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white,
              expandedHeight: 440,

              flexibleSpace: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    /// -- Search bar
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const TSearchContainer(text: 'Search in store', showBorder: true, showBackground: false, padding: EdgeInsets.zero),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// -- Featured Brands
                    TSectionHeading(title: 'Featured Brands', onPressed: (){}),
                    const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                    /// -- Brands grid
                    TGridLayout(itemCount: 4, maxAxisExtent: 80, itemBuilder: (_, index){
                      return const TBrandCard(showBorder: true,);
                    })
                  ],
                ),
              ),
      
              /// -- Tabs
              bottom: const TTabBar(
                  tabs: [
                    Tab(child: Text('Sports')),
                    Tab(child: Text('Furniture')),
                    Tab(child: Text('Electronic')),
                    Tab(child: Text('Clothes')),
                    Tab(child: Text('Cosmetic')),
                  ],
              ),
            ),
          ];
        },
            body: TabBarView(
              children: [
                TCategorytab(),
                TCategorytab(),
                TCategorytab(),
                TCategorytab(),
                TCategorytab(),
              ],
            ),
        ),
      ),
    );
  }
}



