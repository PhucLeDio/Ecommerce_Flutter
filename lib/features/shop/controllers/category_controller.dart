import 'package:flutter_ecommerce/data/repositories/categories/category_repository.dart';
import 'package:flutter_ecommerce/data/repositories/product/product_repository.dart';
import 'package:flutter_ecommerce/features/shop/models/category_model.dart';
import 'package:flutter_ecommerce/features/shop/models/product_model.dart';
import 'package:flutter_ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// Load category data
  Future<void> fetchCategories() async {
    try {
      // show loader while loading
      isLoading.value = true;

      // fetch categories
      final categories = await _categoryRepository.getAllCategories();

      // update the categories
      allCategories.assignAll(categories);

      // filter featured categories
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    } finally {
      // remove loader
      isLoading.value = false;
    }
  }

  /// Load selected category
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories = await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
      return [];
    }
  }

  /// Get category or sub-category products
  Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async {
    try {
      final products = await ProductRepository.instance.getProductsForCategory(categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
      return [];
    }
  }
}