// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/core/failure
// *******************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/core/failure/app_exception.dart';

class FirebaseExc extends AppException{

  const FirebaseExc(super.message);

  factory FirebaseExc.fromFirebaseAuthExc(FirebaseAuthException? errorCode){
    String message = _getFirebaseAuthErrorMessage(errorCode: errorCode);
    return FirebaseExc(message);
  }

  factory FirebaseExc.fromFirebaseExc(FirebaseException? errorCode){
    String message = errorCode?.message??"";
    return FirebaseExc(message);
  }

  static String _getFirebaseAuthErrorMessage({FirebaseAuthException? errorCode}) {
    switch (errorCode!.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return errorCode.message??"";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Please check your password.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return errorCode.message??"";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return errorCode.message??"";
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return errorCode.message??"";
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return errorCode.message??"";
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email has been entered correctly.";
      default:
        return "Login failed. Please try again.";
    }
  }

}


