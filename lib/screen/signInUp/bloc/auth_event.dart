// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen/signInUp/bloc
// *******************************

part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable{

  const AuthEvent();

}

class AuthEmailChanged extends AuthEvent{

  final String email;

  const AuthEmailChanged(this.email);

  @override
  List<Object?> get props => [email];

}

class AuthPasswordChanged extends AuthEvent{

  final String password;

  const AuthPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];

}

class AuthConfirmPasswordChanged extends AuthEvent{

  final String confirmPassword;

  const AuthConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];

}

class AuthSignInUp extends AuthEvent{

  final BuildContext context;

  const AuthSignInUp(this.context);

  @override
  List<Object?> get props => [context];

}

class AuthGoogleSignIn extends AuthEvent{

  final BuildContext context;

  const AuthGoogleSignIn(this.context);

  @override
  List<Object?> get props => [context];

}


class AuthNavigation extends AuthEvent{

  final bool isLogin;
  final bool isNext;
  final BuildContext context;

  const AuthNavigation(this.context,{this.isLogin = true,this.isNext = true});

  @override
  List<Object?> get props => [isLogin,isNext];

}

class AuthChangedMode extends AuthEvent{

  const AuthChangedMode();

  @override
  List<Object?> get props => [];

}


