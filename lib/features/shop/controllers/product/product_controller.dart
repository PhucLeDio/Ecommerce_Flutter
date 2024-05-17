import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/features/shop/models/product_model.dart';
import 'package:flutter_ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/enums/enums.dart';
import '../../../../utils/network/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../models/brand_model.dart';
import '../../models/product_attribute_model.dart';
import '../../models/product_variation_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final productName = TextEditingController();
  final description = TextEditingController();
  final brand = TextEditingController();
  final price = TextEditingController();
  final salePrice = TextEditingController();
  final stock = TextEditingController();
  final title = TextEditingController();
  GlobalKey<FormState> productFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      // show loader
      isLoading.value = true;

      // fetch product
      final products = await productRepository.getFeaturedProducts();

      // Assign product
      featuredProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      // fetch product
      final products = await productRepository.getFeaturedProducts();
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // If no variation exit
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price).toString();
    } else {
      // caculate the smallest and largest
      for (var variation in product.productVariations!) {
        // Determine the price to cosider
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // update smallest and largest prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      // If smallest and largest prices are the same
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        return '$smallestPrice -\$$largestPrice';
      }
    }
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  // check product stock status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In stock' : 'Out of stock';
  }

  // remove product
  void deleteProductById(String productId) async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);

      productRepository.removeProductRecord(productId);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackbar(title: 'Oh snap!', message: e.toString());
    }
  }

  // add new product
  Future addNewProducts() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog('Storing product...', TImages.docerAnimation);

      // check internet connect
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!productFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // save address data
      final newProduct = ProductModel(
        id: '002',
        title: productName.value.text,
        stock: int.parse(stock.value.text),
        price: double.parse(price.value.text),
        isFeatured: true,
        thumbnail: TImages.awaitProduct,
        description: description.value.text,
        brand: BrandModel(id: '2', image: TImages.awaitProduct, name: brand.value.text, productsCount: 265, isFeatured: true),
        images: [TImages.awaitProduct, TImages.awaitProduct, TImages.awaitProduct, TImages.awaitProduct],
        salePrice: double.parse(salePrice.value.text),
        sku: 'ABR4568',
        categoryId: '2',
        productAttributes: [
          ProductAttributeModel (name: 'Color', values: ['Green', 'Black', 'Red']),
          ProductAttributeModel (name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
        ],
        productVariations: [
          ProductVariationModel(
            id: '1',
            stock: 34,
            price: 134,
            salePrice: 122.6,
            image: TImages.awaitProduct,
            description: '',
            attributeValues: {'Color': 'Green', 'Size': 'EU 34'},
          ),
          ProductVariationModel(
            id: '2',
            stock: 15,
            price: 132,
            image: TImages.awaitProduct,
            attributeValues: {'Color': 'Black', 'Size': 'EU 32'},
          ),
          ProductVariationModel(
            id: '3',
            stock: 0,
            price: 234,
            image: TImages.awaitProduct,
            attributeValues: {'Color': 'Black', 'Size': 'EU 34'},
          ),
          ProductVariationModel(
            id: '4',
            stock: 222,
            price: 232,
            image: TImages.awaitProduct,
            attributeValues: {'Color': 'Green', 'Size': 'EU 32'},
          ),
          ProductVariationModel(
            id: '5',
            stock: 0,
            price: 334,
            image: TImages.awaitProduct,
            attributeValues: {'Color': 'Red', 'Size': 'EU 34'},
          ),
          ProductVariationModel(
            id: '6',
            stock: 11,
            price: 332,
            image: TImages.awaitProduct,
            attributeValues: {'Color': 'Red', 'Size': 'EU 32'},
          ),
        ],
        productType: 'ProductType.variable',
      );
      await productRepository.uploadDummyData([newProduct]);

      // remove loader
      TFullScreenLoader.stopLoading();

      // show success message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your product has been saved successfully.');

      // refresh addresses data
      refreshData.toggle();

      // reset fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      // remove loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Product not found', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }

  // reset form fields
  void resetFormFields() {
    productName.clear();
    description.clear();
    brand.clear();
    price.clear();
    salePrice.clear();
    stock.clear();
    title.clear();
    productFormKey.currentState?.reset();
  }
}