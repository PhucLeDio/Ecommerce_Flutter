import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/features/shop/models/banner_model.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  /// variables
  final _db = FirebaseFirestore.instance;

  /// Get all order related
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db.collection('Banners').where('Active', isEqualTo: true).get();
      return result.docs.map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot)).toList();
    } catch (e) {
      throw 'Something went wrong!';
    }
  }

  /// Upload banners to the cloud firebase
}