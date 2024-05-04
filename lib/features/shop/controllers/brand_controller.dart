import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/data/repositories/product/product_repository.dart';
import 'package:flutter_ecommerce/features/shop/models/brand_model.dart';
import 'package:flutter_ecommerce/features/shop/models/product_model.dart';
import 'package:flutter_ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../data/repositories/brands/brand_repository.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  /// Load brand
  Future<void> getFeaturedBrands() async {
    try {
      // Show loader while loading brand
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oops!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// get brand for category

  /// get brand specific product
  Future<List<ProductModel>> getBrandProducts(String brandId) async {
    try {
      final products = await ProductRepository.instance.getProductsForBrand(brandId: brandId);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
      return [];
    }
  }
}