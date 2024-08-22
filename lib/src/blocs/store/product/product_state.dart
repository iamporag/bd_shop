part of 'product_bloc.dart';

sealed class  ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

 final class ProductSuccess extends ProductState {
  final List<ProductModel> product;

  const ProductSuccess({required this.product});
  @override
  List<Object> get props => [product];
 }
 final class ReviewSuccess extends ProductState {
  final List<ReviewModel> review;

  const ReviewSuccess({required this.review});
  @override
  List<Object> get props => [review];
 }

 final class ProductFailed extends ProductState {
  final String message;

  const ProductFailed({required this.message});
  @override
  List<Object> get props => [message];
 }

 final class ProductLoadSuccess extends ProductState {
  final ProductModel product;

  const ProductLoadSuccess({required this.product});
  @override
  List<Object> get props => [product];
 }



