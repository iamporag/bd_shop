
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/models.dart';
import '../../../data/repository/repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  StoreRepository storeRepository;

  CategoryBloc(this.storeRepository) : super(CategoryInitial()) {
    
    on<FetchSingleCategory>((event, emit) async{
    try {
      final category = await storeRepository.fetchSingleCategory(event.categoryId);
      if (category != null) {
        emit(CategoryFetchSuccess(category));
      } else {
        emit(const CategoryFetchFailed(message: "Category Not Found"));
      }
    } catch (e) {
      emit(const CategoryFetchFailed(message: "Unable to load Category"));
    } 
    });
  }
}
