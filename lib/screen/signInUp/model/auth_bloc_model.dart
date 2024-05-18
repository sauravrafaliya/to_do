// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen/signInUp/model
// *******************************

import 'package:flutter/cupertino.dart';

class AuthBlocModel {
  TextEditingController? email;
  TextEditingController? password;
  TextEditingController? confirmPassword;
  bool isValid;
  bool isLogin;
  bool isLoading;
  String message;

  AuthBlocModel({
    this.isLogin = true,
    this.password,
    this.confirmPassword,
    this.email,
    this.isValid = false,
    this.isLoading = false,
    this.message = ""
  });

  AuthBlocModel copyWith({
    TextEditingController? email,
    TextEditingController? password,
    TextEditingController? confirmPassword,
    bool? isValid,
    bool? isLogin,
    bool? isLoading,
    String? message
  }) =>
      AuthBlocModel(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        isValid: isValid ?? this.isValid,
        isLoading: isLoading ?? this.isLoading,
        isLogin: isLogin ?? this.isLogin,
        message: message ?? this.message,
      );
}


