// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/domain/repository
// *******************************


import '../../data/firebase/firestore/user/user_services.dart';

class UserRepository{

  UserServices userServices;

  UserRepository(this.userServices);

  Future<void> createUser(String email)async{
    await userServices.createUser(email);
  }

  Future<bool> userAlreadyExist()async{
    return await userServices.userAlreadyExist();
  }

}