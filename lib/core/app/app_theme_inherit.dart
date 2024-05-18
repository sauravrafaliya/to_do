// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/core/app
// *******************************

import 'package:flutter/material.dart';
import 'package:to_do/core/app/model/app_theme_model.dart';

class AppThemeIn extends InheritedWidget{

  final AppThemeModel appThemeModel;

  const AppThemeIn({super.key,required this.appThemeModel, required super.child});

  static AppThemeIn? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppThemeIn>();
  }

  static AppThemeIn of(BuildContext context) {
    final AppThemeIn? result = maybeOf(context);
    return result!;
  }

  @override
  bool updateShouldNotify(covariant AppThemeIn oldWidget) {
    return appThemeModel != oldWidget.appThemeModel;
  }

}