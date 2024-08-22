import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/models.dart';

class StoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<void> createNewBrand() async {
  //   try {
  //     for (var brand in dummyBrands) {
  //       await _firestore.collection('brands').add(brand.toJson());
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     throw Exception(e);
  //   }
  // }



  Future<List<BrandModel>> fetchBrand() async {
    final List<BrandModel> brandList = [];
    final brandsSnapshot = await _firestore.collection('brands').get();

    try {
      for (var brand in brandsSnapshot.docs) {
        brandList.add(BrandModel.fromJson(brand.data()));
      }
      return brandList;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> fetchAllCategory() async {}

  Future<CategoryModel?> fetchSingleCategory(String categoryId) async {
    try {
      final categoryData =
          await _firestore.collection('category').doc(categoryId).get();
      if (categoryData.data() != null) {
        final category = CategoryModel.fromJson(categoryData.data()!);

        return category;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
