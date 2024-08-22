part of 'login_bloc.dart';


sealed class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}


class LoginInitial extends LoginState {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  List<Object> get props => [emailController,passwordController];
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;
  const LoginFailure(this.message);

    @override
  List<Object> get props => [message];
}
class LogOutLoading extends LoginState {}

class LogOutSuccess extends LoginState {}

class LogOutFailure extends LoginState {
  final String message;
  const LogOutFailure(this.message);

    @override
  List<Object> get props => [message];
}

