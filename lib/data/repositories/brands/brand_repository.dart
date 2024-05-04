import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/features/shop/models/banner_model.dart';
import 'package:flutter_ecommerce/features/shop/models/brand_model.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

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
}