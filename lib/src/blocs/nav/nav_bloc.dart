import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super( const NavInitial()) {
    on<TriggerNavEvent>((event, emit) {
      debugPrint("My tapped index is ${event.index}");
      emit(NavInitial(index: event.index));
    });
  }
}
