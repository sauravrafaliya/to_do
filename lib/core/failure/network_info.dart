// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/core/failure
// *******************************

import 'dart:io';

import 'app_exception.dart';


// For checking internet connectivity
abstract class NetworkInfoImp {

  Future checkConnection();

}

class NetworkInfo implements NetworkInfoImp{

  static NetworkInfo? _instance;

  NetworkInfo ._();

  factory NetworkInfo.instanceFor(){
    return _instance ??= NetworkInfo._();
  }

  static NetworkInfo get instance{
    return NetworkInfo.instanceFor();
  }

  @override
  Future checkConnection() async {
    try{
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      }else{
        throw const NetworkException();
      }
    }catch(e){
      throw const NetworkException();
    }
  }
}

