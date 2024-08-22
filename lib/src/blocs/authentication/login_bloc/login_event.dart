part of 'login_bloc.dart';


sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];

}
class RequestGoogleLogin extends LoginEvent{}
class RequestTwitterLogin extends LoginEvent{}
class RequestFacebookLogin extends LoginEvent{}
class RequestLogOut extends LoginEvent{}

class RequestEmailLogin extends LoginEvent{
  
  final String email;
  final String password;
  final bool isRemember;

  const RequestEmailLogin({required this.email, required this.password, required this.isRemember});

   @override
  List<Object> get props => [email,password,isRemember];
}

