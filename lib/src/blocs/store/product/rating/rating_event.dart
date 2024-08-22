part of 'rating_bloc.dart';

sealed class RatingEvent extends Equatable {
  const RatingEvent();

  @override
  List<Object> get props => [];
}

final class RequestAddReview extends RatingEvent {}


final class UpdateRatingPoint extends RatingEvent {
  final double rating;

  UpdateRatingPoint(this.rating);
  @override
  List<Object> get props => [rating];
}

final class SubmitRatingReview extends RatingEvent {
  final String review;
  final double rating;
  final String productId;
  final List<XFile>? reviewImage;

  SubmitRatingReview(this.review,this.productId, this.rating, this.reviewImage);
  @override
  List<Object> get props => [review,rating,productId];
}

final class FetchProductReview extends RatingEvent {
  // final String review;
  final String productId;

  FetchProductReview(this.productId);
  @override
  List<Object> get props => [productId];
}
