// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/core/config
// *******************************

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do/data/firebase/auth/email_password_auth.dart';
import 'package:to_do/data/firebase/auth/google_authentication.dart';

import '../../data/firebase/firestore/user/user_services.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/user_repository.dart';
import '../../firebase_options.dart';

class InitialConfig{
  static InitialConfig? _instance;

  InitialConfig._();

  factory InitialConfig.instanceFor(){
    return _instance ??= InitialConfig._();
  }

  static InitialConfig get instance{
    return InitialConfig.instanceFor();
  }

  init()async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    GetIt.I.registerSingleton<UserServices>(UserServices());
    GetIt.I.registerSingleton<EmailPasswordAuth>(EmailPasswordAuth());
    GetIt.I.registerSingleton<GoogleAuthentication>(GoogleAuthentication());
    GetIt.I.registerSingleton<UserRepository>(UserRepository(GetIt.I.get<UserServices>()));
    GetIt.I.registerSingleton<AuthRepository>(
      AuthRepository(
        emailPasswordAuth: GetIt.I.get<EmailPasswordAuth>(),
        googleAuthentication: GetIt.I.get<GoogleAuthentication>()
      ),
    );
  }
}