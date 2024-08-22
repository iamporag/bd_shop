part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();
  
  @override
  List<Object> get props => [];

  get message => null;
}

final class SignupInitial extends SignupState {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  List<Object> get props => [usernameController, emailController,passwordController,confirmPasswordController];
}
final class SignupLoading extends SignupState {}
final class SignupSuccess extends SignupState {}
final class SignupFailed extends SignupState {
  @override
  final String message;

  const SignupFailed({
    required this.message
    });

    @override
  List<Object> get props => [message];
}
