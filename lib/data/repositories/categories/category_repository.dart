import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/features/shop/models/category_model.dart';
import 'package:get/get.dart';

import '../../services/firebase_storage_service.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      return list;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// get sub categories
  /// upload categories to the cloud
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      // Upload all the categories along with their Images
      final storage = Get.put(TFirebaseStorageService());

      // Loop through each category
      for (var category in categories) {
        // Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(category.image);

        // upload Image and get its url
        final url = await storage.uploadImageData('Categories', file, category.name);

        // Assign URL to category.image attribute
        category.image = url;

        // Store in firestore
        await _db.collection("Categories").doc(category.id).set(category.toJson());
      }
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}