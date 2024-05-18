// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/core/utils
// *******************************


import 'package:flutter/material.dart';

class HelperFun{

  static buildSnackBar(BuildContext context,String message){
    if(message.isEmpty)return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(duration: const Duration(milliseconds: 1500),
        content: Text(message),)
    );
  }

}