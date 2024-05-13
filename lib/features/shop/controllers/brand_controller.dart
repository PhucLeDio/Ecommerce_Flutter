import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/data/repositories/product/product_repository.dart';
import 'package:flutter_ecommerce/features/shop/models/brand_model.dart';
import 'package:flutter_ecommerce/features/shop/models/product_model.dart';
import 'package:flutter_ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repositories/brands/brand_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/network/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final brandId = TextEditingController();
  final brandName = TextEditingController();
  final isFeature = TextEditingController();
  final productCounts = TextEditingController();
  String? image;
  GlobalKey<FormState> brandFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  RxBool isLoading = true.obs;
  Rx<BrandModel> user = BrandModel.empty().obs;
  final imageUploading = false.obs;
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
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
      return [];
    }
  }

  /// get brand specific product
  Future<List<ProductModel>> getBrandProducts({required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance.getProductsForBrand(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
      return [];
    }
  }

  /// Upload and get brand image
  Future<String> uploadBrandPicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        // Upload image
        final imageUrl = await brandRepository.uploadImage('User/Images/Brands/', image);

        TLoaders.successSnackBar(title: 'Congratulations', message: 'Your brand image has been updated!');

        return imageUrl;
      } else {
        return '';
      }
    } catch (e) {
      TLoaders.warningSnackbar(title: 'Oh Snap!', message: 'Something went wrong: $e');
      return '';
    } finally {
      imageUploading.value = false;
    }
  }

  /// Update brand Image
  updateBrandProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        // Upload image
        final imageUrl = await brandRepository.uploadImage('User/Images/Brands/', image);

        // Update User Image Record
        Map<String, dynamic> json = {'Image': imageUrl};
        await brandRepository.updateSingleField(json);

        user.value.image = imageUrl;
        user.refresh();

        TLoaders.successSnackBar(title: 'Congratulations', message: 'Your brand image has been updated!');
      }
    } catch (e) {
      TLoaders.warningSnackbar(title: 'Oh Snap!', message: 'Something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }

  /// add new brand
  Future addNewBrands() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog('Storing brand...', TImages.docerAnimation);

      // check internet connect
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!brandFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // save address data
      final newBrand = BrandModel(
          id: brandId.value.text,
          image: image.toString(),
          name: brandName.value.text,
          isFeatured: true,
          productsCount: int.parse(productCounts.value.text),
      );
      await brandRepository.saveBrandRecord(newBrand);

      // remove loader
      TFullScreenLoader.stopLoading();

      // show success message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your brands has been saved successfully.');

      // refresh addresses data
      refreshData.toggle();

      // reset fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      // remove loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Brand not found', message: e.toString());
    }
  }

  // reset form fields
  void resetFormFields() {
    brandId.clear();
    brandName.clear();
    isFeature.clear();
    productCounts.clear();
    image = '';
    brandFormKey.currentState?.reset();
  }
}