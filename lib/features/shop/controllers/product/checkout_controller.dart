import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/texts/section_heading.dart';
import 'package:flutter_ecommerce/features/shop/screens/purchase/widgets/billing_payment_section.dart';
import 'package:flutter_ecommerce/features/shop/screens/purchase/widgets/payment_tile.dart';
import 'package:flutter_ecommerce/utils/constants/image_strings.dart';
import 'package:flutter_ecommerce/utils/constants/sizes.dart';
import 'package:flutter_ecommerce/utils/enums/enums.dart';
import 'package:get/get.dart';

import '../../models/payment_method_model.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: 'Paypal', image: TImages.paypal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TSectionHeading(title: 'Select payment method', showActionButton: true,),
                const SizedBox(height: TSizes.spaceBtwSections,),
                TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: TImages.paypal)),
                const SizedBox(height: TSizes.spaceBtwItems / 2,),
              ],
            ),
          ),
        ),
    );
  }
}