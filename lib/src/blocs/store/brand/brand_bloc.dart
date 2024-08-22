
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/brand_model.dart';
import '../../../data/repository/repository.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  StoreRepository repository;
  BrandBloc(this.repository) : super(BrandInitial()) {
    on<FeatchBrand>((event, emit) async{
    try {
      final brands =  await repository.fetchBrand();
      emit(BrandSuccess(brands));
    } catch (e) {
      emit(const BrandFailed(message: "Failed To Load Brands"));
      throw Exception(e);
    }
    });
  }
}
