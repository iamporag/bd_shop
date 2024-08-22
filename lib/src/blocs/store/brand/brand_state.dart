part of 'brand_bloc.dart';

sealed class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

final class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandSuccess extends BrandState {
  final List<BrandModel> brands;

  const BrandSuccess(this.brands);

  @override
  List<Object> get props => [brands];
}

class BrandFailed extends BrandState {
  final String message;

  const BrandFailed({required this.message});
  @override
  List<Object> get props => [message];
}
