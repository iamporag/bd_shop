part of 'review_image_cubit.dart';

sealed class ReviewImageState extends Equatable {
  const ReviewImageState();

  @override
  List<Object> get props => [];
}

final class ReviewImageInitial extends ReviewImageState {}

final class ReviewImageAdded extends ReviewImageState {
  final List <XFile> images;

  ReviewImageAdded(this.images);
  @override
  List<Object> get props => [];
}
final class ReviewImageRemoved extends ReviewImageState {
  final List <XFile> images;

  ReviewImageRemoved(this.images);
  @override
  List<Object> get props => [];
}