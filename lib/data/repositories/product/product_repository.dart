import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_ecommerce/data/services/firebase_storage_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../features/shop/models/product_model.dart';
import '../../../utils/enums/enums.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// firestore instance
  final _db = FirebaseFirestore.instance;

  /// Get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).limit(4).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw 'Something went wrong!';
    }
  }

  /// Get limited featured products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw 'Something went wrong!';
    }
  }

  /// Get limited featured products
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
      return productList;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  Future<List<ProductModel>> getFavouriteProducts(List<String> productIds) async {
    try {
      final snapshot = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();
      return snapshot.docs.map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot)).toList();
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  Future<List<ProductModel>> getProductsForBrand({required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1 ? await _db.collection('Products').where('Brand.Id', isEqualTo: brandId).get() : await _db.collection('Products').where('Brand.Id', isEqualTo: brandId).limit(limit).get();
      final products = querySnapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return products;
    } catch (e) {
      throw 'Something went wrong!';
    }
  }

  Future<List<ProductModel>> getProductsForCategory({required String categoryId, int limit = -4}) async {
    try {
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db.collection('ProductCategory').where('categoryId', isEqualTo: categoryId).get()
          : await _db.collection('ProductCategory').where('categoryId', isEqualTo: categoryId).limit(limit).get();

      List<String> productIds = productCategoryQuery.docs.map((doc) => doc['productId'] as String).toList();

      final productsQuery = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();

      List<ProductModel> products = productsQuery.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();

      return products;
    } catch (e) {
      throw 'Something went wrong!';
    }
  }

  /// Upload dummy data to cloud Firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      // upload all the products
      final storage = Get.put(TFirebaseStorageService());

      // Loop through each product
      for (var product in products) {
        // get image data link from local assets
        final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);

        // upload image and get its URL
        final url = await storage.uploadImageData('Products/Images', thumbnail, product.thumbnail.toString());

        // Assign URL to product.thumbnail
        product.thumbnail = url;

        // product list of images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrl = [];
          for (var image in product.images!) {
            // Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            // upload image and get it url
            final url = await storage.uploadImageData('Products/Images', assetImage, image);

            // assign url to product.thumbnail
            imageUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imageUrl);
        }

        // Upload variation images
        if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            // get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(variation.image);

            // upload image and get url
            final url = await storage.uploadImageData('Products/Images', assetImage, variation.image);

            // Assign url
            variation.image = url;
          }
        }

        // store product in firebase
        await _db.collection("Products").doc(product.id).set(product.toJson());
      }
    } catch (e) {
      throw e.toString();
    }
  }

  /// Remove product data
  Future<void> removeProductRecord(String productId) async {
    try {
      await _db.collection("Products").doc(productId).delete();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload any field
  Future<void> updateSingleField(Map<String, dynamic> json, String productId) async {
    try {
      await _db.collection("Products").doc(productId).update(json);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}