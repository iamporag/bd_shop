part of 'rating_bloc.dart';

sealed class RatingState extends Equatable {
  const RatingState();
  
  @override
  List<Object> get props => [];
}

final class RatingInitial extends RatingState {
  final TextEditingController ratingReviewController = TextEditingController();
}

final class RatingLoading extends RatingState {}

final class RatingSubmitSuccess extends RatingState {}
final class RatingSubmitFailed extends RatingState {
  final String message;

  RatingSubmitFailed(this.message);
  @override
  List<Object> get props => [message];
}

final class RatingFetchSuccess extends RatingState {
  final List<ReviewModel> reviews;

  RatingFetchSuccess(this.reviews);

  @override
  List<Object> get props => [reviews];
}

 final class ReviewLoadSuccess extends RatingState {
  final List<ReviewModel> reviews;

  const ReviewLoadSuccess( this.reviews);
  @override
  List<Object> get props => [reviews];
 }


final class RatingFetchFaileds extends RatingState {
  final String message;

  RatingFetchFaileds(this.message);

  @override
  List<Object> get props => [message];
}

