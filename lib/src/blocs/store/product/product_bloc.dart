
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../data/model/models.dart';
import '../../../data/repository/repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository repository;
  ProductBloc(this.repository) : super(ProductInitial()) {
    on<FetchProduct>((event, emit) async{
      try {
        final products = await repository.fetchProduct();
        emit(ProductSuccess(product: products));
      } catch (e) {
        emit(const ProductFailed(message: "Failed to Load Data"));
        debugPrint('Error : $e');
        throw Exception(e);
      }
    });

  
    
    on<FetchSingleProduct>((event, emit) async{
     try {
       final product = await repository.fetchSingleProduct(event.productId);
      if (product != null) {
        emit(ProductLoadSuccess(product: product));
      } else {
        emit(const ProductFailed(message: "Unable To Load Product From Server"));
      }
     } catch (e) {
       emit(const ProductFailed(message: "Failed to Load Product"));
     }
    });
  }
}
