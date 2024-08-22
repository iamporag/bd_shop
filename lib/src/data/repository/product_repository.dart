import 'dart:io';

import 'package:bd_shop/src/data/model/product_model.dart';
import 'package:bd_shop/src/data/model/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/web.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<ProductModel>> fetchProduct() async {
    final List<ProductModel> productList = [];
    try {
      final productSnapshot = await _firestore.collection('products').get();
      for (var product in productSnapshot.docs) {
        final singleProduct = ProductModel.fromJson(product.data());
        singleProduct.productId = product.id;
        productList.add(singleProduct);
      }
      return productList;
    } catch (e) {
      Logger().e('Error: $e');
      throw Exception(e);
    }
  }

  Future<ProductModel?> fetchSingleProduct(String productId) async {
    try {
      final data = await _firestore.collection('products').doc(productId).get();

      if (data.data() != null) {
        final product = ProductModel.fromJson(data.data()!);
        product.productId = data.id;
        return product;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }

  Future<ReviewModel?> submitReviewWithRating(ReviewModel review) async {
    try {
      List<String> reviewImageUrls = [];

      if (review.image != null) {
        for (var image in review.image!) {
          final snapshot = await _storage
              .ref('/reviews/${image.title}')
              .putFile(File(image.url!));
          reviewImageUrls.add(await snapshot.ref.getDownloadURL());
        }
      }
      List<ImageModel> reviewImages = [];

      for (var i = 0; i < reviewImageUrls.length; i++) {
        if (review.image != null) {
          reviewImages.add(ImageModel(
              title: review.image![i].title, url: reviewImageUrls[i]));
        }
      }

      final updatedReview = ReviewModel(
          userId: review.userId,
          userName: review.userName,
          userProfilePic: review.userProfilePic,
          productId: review.productId,
          review: review.review,
          rating: review.rating,
          image: reviewImages,
          createdAt: review.createdAt);

      final data = await _firestore
          .collection('products')
          .doc(review.productId)
          .collection('reviews')
          .add(updatedReview.toJson());
      final document = await data.get();
      if (document.data() != null) {
        final review = ReviewModel.fromJson(document.data()!);
        return review;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }

  // Future<List<ReviewModel>> fetchReview() async {
  //   final List<ReviewModel> reviewList = [];
  //   try {
  //     final reviewSnapshot = await _firestore.collection('reviews').get();
  //     for (var reviews in reviewSnapshot.docs) {
  //       final singleReview = ReviewModel.fromJson(reviews.data());
  //       reviewList.add(singleReview);
  //     }
  //     return reviewList;
  //   } catch (e) {
  //     debugPrint("Error: $e");
  //     throw Exception(e);
  //   }
  // }

  Future<List<ReviewModel>> FetchProductReview(String productId) async {
    List<ReviewModel> reviews = [];
    try {
      final data = await _firestore
          .collection('products')
          .doc(productId)
          .collection('reviews')
          .get();

      if (data.docs.isNotEmpty) {
        for (var review in data.docs) {
          reviews.add(ReviewModel.fromJson(review.data()));
        }
      }
      return reviews;
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }
}
