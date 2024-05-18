// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen/signInUp/bloc
// *******************************

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/core/failure/app_exception.dart';
import 'package:to_do/core/utils/helper_fun.dart';
import 'package:to_do/core/utils/string_extension.dart';
import 'package:to_do/domain/repository/user_repository.dart';
import 'package:to_do/screen/landing/view/landing_screen.dart';
import 'package:to_do/screen/signInUp/model/auth_bloc_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/repository/auth_repository.dart';
import '../view/sign_in_up_screen.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{

  final AuthRepository authRepository;
  final UserRepository userRepository;

  AuthBloc({required this.authRepository,required this.userRepository}) : super(AuthLoginState()){
    on<AuthEmailChanged>(_onEmailChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<AuthSignInUp>(_onSignInUp);
    on<AuthGoogleSignIn>(_onGoogleSignIn);
    on<AuthChangedMode>(_onChangedMode);
    on<AuthNavigation>(_onNavigation);
  }

  void _onEmailChanged(AuthEmailChanged event,Emitter<AuthState> emit){
    AuthBlocModel authBlocModel = state.authBlocModel??AuthBlocModel();
    TextEditingController controller = authBlocModel.email??TextEditingController();
    controller.text = event.email;
    _isValid(authBlocModel.copyWith(email: controller), emit);
  }

  void _onPasswordChanged(AuthPasswordChanged event,Emitter<AuthState> emit){
    AuthBlocModel authBlocModel = state.authBlocModel??AuthBlocModel();
    TextEditingController controller = authBlocModel.password??TextEditingController();
    controller.text = event.password;
    _isValid(authBlocModel.copyWith(password: controller), emit);
  }

  void _onConfirmPasswordChanged(AuthConfirmPasswordChanged event,Emitter<AuthState> emit){
    AuthBlocModel authBlocModel = state.authBlocModel??AuthBlocModel();
    TextEditingController controller = authBlocModel.confirmPassword??TextEditingController();
    controller.text = event.confirmPassword;
    _isValid(authBlocModel.copyWith(confirmPassword: controller), emit);
  }

  void _isValid(AuthBlocModel state,Emitter<AuthState> emit){
    AuthBlocModel authBlocModel = state;
    bool isValid = authBlocModel.isValid;
    String email = authBlocModel.email?.text??"";
    String password = authBlocModel.password?.text??"";
    String confirmPassword = authBlocModel.confirmPassword?.text??"";
    if(authBlocModel.isLogin){
      isValid = email.isNotEmpty && password.isNotEmpty;
    }else{
      isValid = email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty;
    }
    emit(AuthState(authBlocModel.copyWith(
        isValid: isValid
    )));
    emit(AuthState(authBlocModel.copyWith(isValid: isValid)));
  }

  void _onSignInUp(AuthSignInUp event,Emitter<AuthState> emit)async{
    AuthBlocModel authBlocModel = state.authBlocModel??AuthBlocModel();
    if(!_validator(event.context, authBlocModel))return;
    try{
      emit(AuthState(authBlocModel.copyWith(
          isLoading: true
      )));
      if(authBlocModel.isLogin){
        await authRepository.loginWithEmailPassword(authBlocModel.email?.text??"", authBlocModel.password?.text??"");
      }else{
        await authRepository.registerWithEmailPassword(authBlocModel.email?.text??"", authBlocModel.password?.text??"");
        await userRepository.createUser(authBlocModel.email?.text??"");
      }
      Future.delayed(const Duration(seconds: 0),(){
        Navigator.pushAndRemoveUntil(
          event.context,
          MaterialPageRoute(builder: (context) => const LandingScreen()),
          (route) => false,
        );
      });
      emit(AuthState(authBlocModel.copyWith(
          isLoading: false
      )));
    }on AppException catch(e){
      emit(AuthError(authBlocModel.copyWith(
        message: e.message
      )));
    }catch(e){
      emit(AuthError(authBlocModel.copyWith(
          message: e.toString()
      )));
    }
  }

  void _onGoogleSignIn(AuthGoogleSignIn event,Emitter<AuthState> emit)async{
    AuthBlocModel authBlocModel = state.authBlocModel??AuthBlocModel();
    if(!_validator(event.context, authBlocModel))return;
    try{
      await authRepository.loginWithGoogle();
      if(!await userRepository.userAlreadyExist()){
        await userRepository.createUser(authBlocModel.email?.text??"");
      }
      Future.delayed(const Duration(seconds: 0),(){
        Navigator.pushAndRemoveUntil(
          event.context,
          MaterialPageRoute(builder: (context) => const LandingScreen()),
              (route) => false,
        );
      });
    }on AppException catch(e){
      emit(AuthError(authBlocModel.copyWith(
          message: e.message
      )));
    }catch(e){
      emit(AuthError(authBlocModel.copyWith(
          message: e.toString()
      )));
    }
  }

  void _onNavigation(AuthNavigation event,Emitter<AuthState> emit){
    AuthBlocModel authBlocModel = AuthBlocModel(
      confirmPassword: TextEditingController(),
      password: TextEditingController(),
      email: TextEditingController(),
      isLogin: event.isLogin,
      isLoading: false,
      isValid: false
    );
    emit(AuthState(authBlocModel));
    if(event.isNext){
      Navigator.push(
        event.context,
        MaterialPageRoute(builder: (context) => const SignInUpScreen()),
      );
    }else{
      Navigator.pushAndRemoveUntil(
        event.context,
        MaterialPageRoute(builder: (context) => const SignInUpScreen()),
        (route) => false,
      );
    }
  }

  bool _validator(BuildContext context,AuthBlocModel state){
    FocusScope.of(context).unfocus();
    AuthBlocModel authBlocModel = state;
    String email = authBlocModel.email?.text??"";
    String password = authBlocModel.password?.text??"";
    String confirmPassword = authBlocModel.confirmPassword?.text??"";
    String message = "";
    if(!email.isEmail){
      message = AppLocalizations.of(context)?.invalid_email??"";
    }else if(!authBlocModel.isLogin && password != confirmPassword){
      message = AppLocalizations.of(context)?.mismatch_pass??"";
    }
    HelperFun.buildSnackBar(context, message);
    return message.isEmpty;
  }

  void _onChangedMode(AuthChangedMode event,Emitter<AuthState> emit){
    AuthBlocModel authBlocModel = state.authBlocModel??AuthBlocModel();
    if(authBlocModel.isLogin){
      authBlocModel = authBlocModel.copyWith(
      isLogin: false,
      isValid: false,
      password: TextEditingController(),
      email: TextEditingController(),
      confirmPassword: TextEditingController(),
     );
    }else{
      authBlocModel = authBlocModel.copyWith(
        isLogin: true,
        isValid: false,
        password: TextEditingController(),
        email: TextEditingController(),
        confirmPassword: TextEditingController(),
      );
    }
    _isValid(authBlocModel, emit);
  }


}
