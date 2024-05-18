// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/data/firebase/auth
// *******************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/core/failure/app_exception.dart';
import 'package:to_do/core/failure/firebase_exception.dart';
import 'package:to_do/core/failure/network_info.dart';

import 'auth_imp.dart';

class EmailPasswordAuth implements AuthImp {

  @override
  Future<String> login([String email = "", String password = ""]) async {
    await checkNetwork();
    try{
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if(credential.user != null){
        return credential.user?.uid??"";
      }else{
        throw const SomethingWrongException();
      }
    }on FirebaseAuthException catch (error){
      throw FirebaseExc.fromFirebaseAuthExc(error);
    } catch(_){
      throw const SomethingWrongException();
    }
  }

  @override
  Future<void> logout()async {
    await checkNetwork();
    try{
      await FirebaseAuth.instance.signOut();
    }on FirebaseAuthException catch (error){
      throw FirebaseExc.fromFirebaseAuthExc(error);
    } catch(_){
      throw const SomethingWrongException();
    }
  }

  @override
  Future<String> register([String email = "", String password = ""])async {
    await checkNetwork();
    try{
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if(credential.user != null){
        return credential.user?.uid??"";
      }else{
        throw const SomethingWrongException();
      }
    }on FirebaseAuthException catch (error){
      throw FirebaseExc.fromFirebaseAuthExc(error);
    } catch(_){
      throw const SomethingWrongException();
    }
  }

  @override
  Future<void> checkNetwork()async {
    await NetworkInfo.instance.checkConnection();
  }
}
