import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../data/repository/repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<RequestGoogleLogin>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await repository.signInWithGoogle();
        debugPrint("User: ${user?.displayName}");
        emit(LoginSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(LoginFailure(e.toString()));
      }
    });

    on<RequestFacebookLogin>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = repository.signInWithFacebook();
        debugPrint("User: ${user.toString()}");
        emit(LoginSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(LoginFailure(e.toString()));
      }
    });

    on<RequestTwitterLogin>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await repository.signInWithTwitter();
        debugPrint("User: ${user?.displayName}");
        if (user != null) {}
        emit(LoginSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(LoginFailure(e.toString()));
      }
    });

    on<RequestEmailLogin>((event, emit) async {
      emit(LoginLoading());
      try {
        await repository
            .signInWithEmail(event.email, event.password)
            .then((value) => emit(LoginSuccess()));
      } catch (e) {
        debugPrint(e.toString());
        emit(LoginFailure(e.toString()));
      }
    });
   
    on<RequestLogOut>((event, emit) async {
      emit(LogOutLoading());
      try {
        await repository.logOut().then((value) {
          emit(LogOutSuccess());
          emit(LoginInitial());
        });
      } catch (e) {
        debugPrint(e.toString());
        emit(LogOutFailure(e.toString()));
      }
    });
  }

  FutureOr<void> requestGoogleLogin(
      RequestGoogleLogin event, Emitter<LoginState> emit) async {}
}
















  // on<FacebookLoginButtonAction>(facebookloginButtonAction);
  // on<TwitterLoginButtonAction>(twitterLoginButtonAction);
  // on<GoogleLoginButtonAction>(googleLoginButtonAction);
  // }

  // FutureOr<void> facebookloginButtonAction(FacebookLoginButtonAction event, Emitter<LoginState> emit) {
  //  emit(LoginNavigatePageAction());
  // }

  // FutureOr<void> twitterLoginButtonAction(TwitterLoginButtonAction event, Emitter<LoginState> emit) {
  // print("Twitter");
  //  emit(LoginNavigatePageAction());
  // }

  // FutureOr<void> googleLoginButtonAction(GoogleLoginButtonAction event, Emitter<LoginState> emit) {
  // print("Google");
  //  emit(LoginNavigatePageAction());
  // }



