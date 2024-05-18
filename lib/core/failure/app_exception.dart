// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/core/failure
// *******************************

abstract class AppException implements Exception{

  final String message;

  const AppException(this.message);

}

class NetworkException extends AppException{

  const NetworkException() : super("Please check internet connection");

}

class SomethingWrongException extends AppException{

  const SomethingWrongException() : super("Something went wrong");

}

class UnknownException extends AppException{

  const UnknownException() : super("Unknown operation");

}