// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/data/firebase/firestore
// *******************************

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/core/utils/app_typedef.dart';
import 'package:to_do/data/firebase/firebase_caller.dart';
import 'package:to_do/data/firebase/firestore/user/model/user_model.dart';

class UserServices{

  final _userRef = FirebaseFirestore.instance.collection("user");

  Future<UserModel> getUserInfo()async{
    try{
      String uid = FirebaseAuth.instance.currentUser?.uid??"";
      return await FirestoreCaller.caller<FSDocumentRef,UserModel>(_userRef.doc(uid)) as UserModel;
    }catch (_){
      rethrow;
    }
  }

  Future<void> createUser(String email)async{
    try{
      String uid = FirebaseAuth.instance.currentUser?.uid??"";
      if(uid.isEmpty)return;
      await FirestoreCaller.caller<FSDocumentRef,UserModel>(
        _userRef.doc(uid),
        operation: FSOperation.set,
        payLoad: {
          "id" : uid,
          "email" : email
        }
      );
    }catch (_){
      rethrow;
    }
  }

  Future<bool> userAlreadyExist()async{
    try{
      String uid = FirebaseAuth.instance.currentUser?.uid??"";
      if(uid.isEmpty)return false;
      final response = await FirestoreCaller.caller<FSDocumentRef,UserModel>(
          _userRef.doc(uid),
      ) as FSDocumentMap;
      if(response.exists) {
        return true;
      } else {
        return false;
      }
    }catch (_){
      rethrow;
    }
  }

}