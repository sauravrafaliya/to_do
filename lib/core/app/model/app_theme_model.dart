// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/core/app/model
// *******************************

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:to_do/core/utils/color_extension.dart';

AppThemeModel appThemeFromJson(String str) => AppThemeModel.fromJson(json.decode(str));

String appThemeToJson(AppThemeModel data) => json.encode(data.toJson());

class AppThemeModel {
  late Color blackWhiteColor;
  Color navigationBarColor;
  String appColor;
  int appTheme;
  String appLan;
  String typo;

  AppThemeModel({
    this.appColor = "#8875FF",
    this.appTheme = 1,
    this.appLan = "en",
    this.typo = "Lato",
    this.navigationBarColor = Colors.black,
  }){
    if(appTheme == 1){
      blackWhiteColor = Colors.white;
    }else{
      blackWhiteColor = Colors.black;
    }
  }

  Color get appThemeColor{
    return appColor.toColor();
  }

  Locale get appLocal{
    return Locale(appLan);
  }

  ThemeMode get appThemeMode{
    return appTheme == 1 ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDarkMode{
    return appTheme == 1;
  }

  AppThemeModel copyWith({
    String? appColor,
    int? appTheme,
    String? appLan,
    String? typo,
    Color? navigationBarColor,
  }) =>
      AppThemeModel(
        appColor: appColor ?? this.appColor,
        appTheme: appTheme ?? this.appTheme,
        appLan: appLan ?? this.appLan,
        typo: typo ?? this.typo,
        navigationBarColor: navigationBarColor ?? this.navigationBarColor,
      );

  factory AppThemeModel.fromJson(Map<String, dynamic> json) => AppThemeModel(
    appColor: json["app_color"]??"#8875FF",
    appTheme: json["app_theme"]??1,
    navigationBarColor: json["navigationBarColor"]??1,
    appLan: json["app_lan"]??"en",
    typo: json["typo"]??"Lato",
  );

  Map<String, dynamic> toJson() => {
    "app_color": appColor,
    "navigationBarColor": navigationBarColor,
    "app_theme": appTheme,
    "app_lan": appLan,
    "typo": typo,
  };
}
