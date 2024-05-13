import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/widgets.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({required this.id, required this.image, required this.name, this.isFeatured, this.productsCount});

  /// Empty helper
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  /// convert to json
  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductCounts': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
        id: data['Id'] ?? '',
        image: data['Image'] ?? '',
        name: data['Name'] ?? '',
        productsCount: data['ProductCounts'] ?? 0,
        isFeatured: data['IsFeatured'] ?? false,
    );
  }

  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Map json record
      return BrandModel(
          id: document.id,
          name: data['Name'] ?? '',
          image: data['Image'] ?? '',
          productsCount: data['ProductCounts'] ?? '',
          isFeatured: data['IsFeatured'] ?? true,
      );
    } else {
      return BrandModel.empty();
    }
  }
}