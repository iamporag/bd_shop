part of 'rating_point_cubit.dart';

sealed class RatingPointState extends Equatable {
  const RatingPointState();

  @override
  List<Object> get props => [];
}

final class RatingPointInitial extends RatingPointState {}

final class RatingPointChanged extends RatingPointState {
final double ratingPoint;

  RatingPointChanged(this.ratingPoint);
  @override
  List<Object> get props => [ratingPoint];
}