import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/shop/controllers/product/images_controller.dart';
import 'package:flutter_ecommerce/features/shop/models/product_model.dart';
import 'package:flutter_ecommerce/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    return TCurvedEdgeWidget(
        child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
          child: Stack(
            children: [
              ///--main large image
              SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.productImageRadius),
                  child: Center(child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(imageUrl: image, progressIndicatorBuilder: (_, __, downloadProgress) =>
                          CircularProgressIndicator(value: downloadProgress.progress, color: TColors.primary),
                      ),
                    );
                  })),
                ),
              ),

              ///--image slider
              Positioned(
                right: 0,
                bottom: 30,
                left: TSizes.defaultSpace,
                child: SizedBox(
                  height: 80,
                  child: ListView.separated(
                    separatorBuilder: (_, __) => const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    itemCount: images.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => Obx(
                      (){
                        final imageSelected = controller.selectedProductImage.value == images[index];
                        return TRoundedImage(
                          width: 80,
                          isNetworkImage: true,
                          imageUrl: images[index],
                          backgroundColor: dark ? TColors.dark : TColors.white,
                          border: Border.all(color: imageSelected ? TColors.primary : Colors.transparent),
                          onPressed: () => controller.selectedProductImage.value = images[index],
                          padding: const EdgeInsets.all(TSizes.sm),
                        );
                      },
                    ),
                  ),
                ),
              ),

              ///--appbar icon
              const TAppBar(
                showBackArrow: true,
                actions: [TCircularIcon(icon: Iconsax.heart5, color: Colors.red)],
              ),
            ],
          ),
    ));
  }
}
