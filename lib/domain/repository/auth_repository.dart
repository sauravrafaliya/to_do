// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/domain/repository
// *******************************

import 'package:to_do/data/firebase/auth/email_password_auth.dart';
import 'package:to_do/data/firebase/auth/google_authentication.dart';

class AuthRepository{

  EmailPasswordAuth emailPasswordAuth;
  GoogleAuthentication googleAuthentication;

  AuthRepository({required this.googleAuthentication,required this.emailPasswordAuth});

  Future loginWithEmailPassword(String email,String password)async{
    await emailPasswordAuth.login(email,password);
  }

  Future registerWithEmailPassword(String email,String password)async{
    await emailPasswordAuth.register(email,password);
  }

  Future loginWithGoogle()async{
    await googleAuthentication.login();
  }



}