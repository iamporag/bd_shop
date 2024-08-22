
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'rating_point_state.dart';


class RatingPointCubit extends Cubit<RatingPointState> {
  RatingPointCubit() : super(RatingPointInitial());

    double ratingPoint = 0.0;

  void updateRatingPoint (double rating) {
     ratingPoint = rating;
     emit(RatingPointChanged(ratingPoint));
  }
}
