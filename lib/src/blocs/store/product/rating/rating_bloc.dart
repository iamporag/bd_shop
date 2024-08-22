import 'dart:io';

import 'package:bd_shop/src/data/model/models.dart';
import 'package:bd_shop/src/data/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final ProductRepository repository;
  RatingBloc(this.repository) : super(RatingInitial()) {
    on<RequestAddReview>((event, emit) => emit(RatingInitial()));

    on<SubmitRatingReview>((event, emit) async {
      emit(RatingLoading());
      final currentUser = FirebaseAuth.instance.currentUser;
      final List<ImageModel> reviewImages = [];

      if (event.reviewImage != null) {
        for (var xFile in event.reviewImage!) {
          reviewImages.add(ImageModel(title: xFile.name,url: xFile.path));
        }
      }
      
      
      final review = ReviewModel(
        userId: currentUser?.uid,
        userName: currentUser?.displayName,
        userProfilePic: currentUser?.photoURL,
        productId: event.productId,
        review: event.review,
        rating: event.rating,
        image: reviewImages,
        createdAt: Timestamp.now(),
      );
      try {
        final response = await repository.submitReviewWithRating(review);
        if (response != null) {
          emit(RatingSubmitSuccess());
        } else {
          emit(RatingSubmitFailed("Something Wrong! try again"));
        }
      } catch (e) {
        emit(RatingSubmitFailed("Server Error"));
      }
      // print("Review: ${event.review} Star : $rating");
    });

    on<FetchProductReview>((event, emit) async {
      try {
        final reviews = await repository.FetchProductReview(event.productId);
        emit(ReviewLoadSuccess(reviews));
      } catch (e) {
        emit(RatingFetchFaileds('Failed to load Reviews'));
      }
    });
  }
}
