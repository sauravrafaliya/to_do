// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/data/firebase
// *******************************


// // *******************************
// // Develop by : Saurav Rafaliya
// // Date : 24 December,2023
// // Path : lib/domain/firebase_firestore
// // *******************************

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do/core/failure/app_exception.dart';
import 'package:to_do/core/failure/firebase_exception.dart';
import 'package:to_do/data/firebase/firestore/user/model/user_model.dart';

import '../../core/failure/network_info.dart';
import '../../core/utils/app_typedef.dart';

class FirestoreCaller{

  static Future<Object?> caller<T,E>(T ref,{
    Map<String,dynamic> payLoad = const {},
    FSOperation? operation
  })async{
    Object? response;
    await NetworkInfo.instance.checkConnection();
    try{
      if(ref is FSDocumentRef && operation != null){
        switch(operation) {
          case FSOperation.set:
            await (ref).set(payLoad);
          case FSOperation.update:
            await (ref).update(payLoad);
          case FSOperation.delete:
            await (ref).delete();
          default:
            throw const UnknownException();
        }
      }else if(ref is FSCollectionRef && operation == FSOperation.add){
        response = await (ref).add(payLoad);
      }else if(ref is FSDocumentRef){
        await (ref).get().then((value){
          response = convertResponseData<E>(value);
          return null;
        });
      }else if(ref is FSCollectionRef){
        await (ref).get().then((value){
          response = convertResponseData<E>(value.docs);
          return null;
        });
      }else{
        throw const UnknownException();
      }
      return response;
    }on FirebaseException catch(e){
      throw FirebaseExc.fromFirebaseExc(e);
    }on SocketException catch(_){
      throw const NetworkException();
    }catch (_){
      throw const SomethingWrongException();
    }
  }

  static Object? convertResponseData<E>(dynamic data){
    Object? responseData;
    if(E != dynamic){
      if(data is List<QueryDocumentSnapshot>){
        responseData = convertJsonListToTypeList<E>(data);
      }else if(data is DocumentSnapshot){
        responseData = convertJsonMapToTypeMap<E>(data);
      }else{
        responseData = data;
      }
    }else{
      responseData = data;
    }
    return responseData;
  }

  static List<E> convertJsonListToTypeList<E>(List<QueryDocumentSnapshot> data){
    List<E> result = [];
    for (var element in data) {
      result.add(_fromJson<E>(element.data() as Map));
    }
    return result;
  }

  static E? convertJsonMapToTypeMap<E>(DocumentSnapshot data){
    return _fromJson<E>(data.data() as Map);
  }

  static E _fromJson<E>(Map json) {
    if(E == UserModel){
      return UserModel.fromJson(json as Map<String,dynamic>) as E;
    }
    throw ArgumentError("Unknown type: $E");
  }


}