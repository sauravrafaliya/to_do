// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen/signInUp/bloc
// *******************************

part of 'auth_bloc.dart';

class AuthState extends Equatable{

  final AuthBlocModel? authBlocModel;

  const AuthState([this.authBlocModel]);

  @override
  List<Object?> get props => [authBlocModel];

}

class AuthLoginState extends AuthState{

  AuthLoginState() : super(AuthBlocModel(
      password: TextEditingController(),
      email: TextEditingController(),
      isValid: false,
      confirmPassword: TextEditingController(),
      isLoading: false,
      isLogin: true
  ));

  @override
  List<Object?> get props => [authBlocModel];
}

class AuthRegisterState extends AuthState{

  AuthRegisterState() : super(AuthBlocModel(
      password: TextEditingController(),
      email: TextEditingController(),
      isValid: false,
      confirmPassword: TextEditingController(),
      isLoading: false,
      isLogin: false
  ));

  @override
  List<Object?> get props => [authBlocModel];
}

class AuthError extends AuthState{

  const AuthError(super.authBlocModel);

  @override
  List<Object?> get props => [authBlocModel];

}