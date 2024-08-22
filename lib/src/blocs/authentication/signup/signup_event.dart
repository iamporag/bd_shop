part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class RequestEmailSignUp extends SignupEvent {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  const RequestEmailSignUp({
    required this.username, 
    required this.email, 
    required this.password, 
    required this.confirmPassword
    });
}
