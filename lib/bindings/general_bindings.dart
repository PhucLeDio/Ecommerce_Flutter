import 'package:flutter_ecommerce/features/shop/controllers/product/variation_controller.dart';
import 'package:flutter_ecommerce/utils/network/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
  }

}