import 'package:bd_shop/src/data/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AuthRepository repository ;
  SignupBloc(this.repository) : super(SignupInitial()) {

    on<RequestEmailSignUp>((event, emit) async{
     emit(SignupLoading());
     try {
       final user = await repository.signUpWithEmail(event.email, event.password, event.username);
       emit(SignupSuccess());
       debugPrint("User email : ${user!.email}");
     } catch (e) {
       emit(SignupFailed(message: "$e"));
     }
    });
  }
}
