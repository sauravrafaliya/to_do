// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/data/firebase/auth
// *******************************


abstract class AuthImp{

  Future<String> login([String email,String password]);

  Future<String> register([String email = "",String password = ""]);

  Future<void> logout();

  Future<void> checkNetwork();


}

