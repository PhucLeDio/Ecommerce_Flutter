import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_ecommerce/features/shop/models/banner_model.dart';
import 'package:flutter_ecommerce/features/shop/models/brand_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../authentication/authentication_repository.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// save data to firestore
  Future<void> saveBrandRecord(BrandModel brand) async {
    try {
      await _db.collection("Brands").doc(brand.id).set(brand.toJson());
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get all categories
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final result = snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } catch (e) {
      throw 'Something went wrong!';
    }
  }

  /// Get brand for category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      // Query to get all documents
      QuerySnapshot brandCategoryQuery = await _db.collection('BrandCategory').where('categoryId', isEqualTo: categoryId).get();

      // Extract brandIds
      List<String> brandIds = brandCategoryQuery.docs.map((doc) => doc['brandId'] as String).toList();

      final brandsQuery = await _db.collection('Brands').where(FieldPath.documentId, whereIn: brandIds).limit(2).get();

      List<BrandModel> brands = brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      return brands;
    } catch (e) {
      throw 'Something went wrong!';
    }
  }

  /// update any field
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("Brands").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload Image
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
}