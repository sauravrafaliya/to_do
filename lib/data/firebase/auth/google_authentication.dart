// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/data/firebase/auth
// *******************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/failure/app_exception.dart';
import '../../../core/failure/firebase_exception.dart';
import '../../../core/failure/network_info.dart';
import 'auth_imp.dart';

class GoogleAuthentication implements AuthImp{

  @override
  Future<String> login([String email = "", String password = ""]) async {
    await checkNetwork();
    try{

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential =  await FirebaseAuth.instance.signInWithCredential(credential);
      if(userCredential.user != null){
        return userCredential.user?.uid??"";
      }else{
        throw const SomethingWrongException();
      }

    }on FirebaseAuthException catch (error){
      throw FirebaseExc.fromFirebaseAuthExc(error);
    }on FirebaseException catch (error){
      throw FirebaseExc.fromFirebaseExc(error);
    } catch(_){
      throw const SomethingWrongException();
    }
  }

  @override
  Future<void> logout()async {
    await checkNetwork();
    try{
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    }on FirebaseAuthException catch (error){
      throw FirebaseExc.fromFirebaseAuthExc(error);
    }on FirebaseException catch (error){
      throw FirebaseExc.fromFirebaseExc(error);
    } catch(_){
      throw const SomethingWrongException();
    }
  }

  @override
  Future<String> register([String email = "", String password = ""])async {
    throw UnimplementedError();
  }

  @override
  Future<void> checkNetwork()async {
    await NetworkInfo.instance.checkConnection();
  }
}

// Live Template name : sngl
// Description : New Singleton class
// ---------------------------------------------------
// class $NAME${
//   static $NAME$? _instance;
//
//   $NAME$._();
//
//   factory $NAME$.instanceFor(){
//     return _instance ??= $NAME$._();
//   }
//
//   static $NAME$ get instance{
//     return $NAME$.instanceFor();
//   }
// }

// Live Template name : snglchnge
// Description : Singleton instance with change notifier
// ---------------------------------------------------
// class $NAME$ extends ChangeNotifier{
//   static $NAME$? _instance;
//
//   $NAME$._();
//
//   factory $NAME$.instanceFor(){
//     return _instance ??= $NAME$._();
//   }
//
//   static $NAME$ get instance{
//     return $NAME$.instanceFor();
//   }
// }