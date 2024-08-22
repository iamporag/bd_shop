import 'package:bd_shop/src/data/repository/store_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  StoreRepository repository = StoreRepository();

  void startSplash() {
  //  try {
  //     await repository.createNewBrand();
  //   await repository.createProduct();
  //  } catch (e) {
  //    debugPrint(e.toString());
  //  }
    Future.delayed(const Duration(seconds: 2), (){
       emit(EndSplash());
    });
  }

}
