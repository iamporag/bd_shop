import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'remember_state.dart';

class RememberCubit extends Cubit<RememberState> {
  RememberCubit() : super(RememberInitial());

  static bool isRemember = true;

    void switchToggle(bool value){
      isRemember = value;
      emit(SwitchStatusChange(isRemember));
  }
}
