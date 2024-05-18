// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/core/const
// *******************************

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/core/app/model/app_theme_model.dart';

import '../utils/custom_text_style.dart';

class AppTheme{

  static Color borderColor = const Color(0xFF979797);

  static List<String> colors = [
    "#8875FF",
    "#DF9034",
    "#EC8282",
    "#E786C6",
  ];

  static List<AppLan> languages = [
    AppLan(
      lanCode: "en",
      lanName: "English"
    ),
    AppLan(
      lanName: "Spanish",
      lanCode: "es"
    ),
    AppLan(
      lanCode: "ar",
      lanName: "Arabic"
    )
  ];

  static List<String> fonts = [
    familyLato,
    familyRoboto,
    familyMontserrat,
    familyNunito,
    familyOpenSans
  ];

  Color primaryColor = const Color(0xFF8875FF);

  static String familyLato = "Lato";
  static String familyMontserrat = "Montserrat";
  static String familyNunito = "Nunito";
  static String familyOpenSans = "OpenSans";
  static String familyRoboto = "Roboto";

  static ThemeData getLightTheme(AppThemeModel appTheme){
    bool isDark = appTheme.appThemeMode == ThemeMode.dark;
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: appTheme.appThemeColor,
      scaffoldBackgroundColor: Colors.white,
      colorScheme:  ColorScheme.fromSeed(
        seedColor: appTheme.appThemeColor,
        brightness: Brightness.light,
        background: Colors.white,
        secondary: CupertinoColors.systemGrey3,
        onBackground: Colors.white,
      ),
      floatingActionButtonTheme: getFloatingActionButtonThemeData(appTheme),
      bottomNavigationBarTheme: getBottomNavigationBarThemeData(appTheme),
      appBarTheme: _getAppBarThemeData(isDark),
      inputDecorationTheme: _getInputDecorationTheme(appTheme),
      elevatedButtonTheme: _getElevatedButtonThemeData(appTheme),
      outlinedButtonTheme: _getOutlinedButtonThemeData(appTheme),
      textButtonTheme: _getTextButtonThemeData(appTheme),
      useMaterial3: true,
      fontFamily: appTheme.typo,
    );
  }

  static ThemeData getDarkTheme(AppThemeModel appTheme){
    bool isDark = appTheme.appThemeMode == ThemeMode.dark;
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: appTheme.appThemeColor,
        brightness: Brightness.dark,
        background: CupertinoColors.black,
        secondary: CupertinoColors.placeholderText,
        onBackground: CupertinoColors.darkBackgroundGray,
      ),
      floatingActionButtonTheme: getFloatingActionButtonThemeData(appTheme),
      bottomNavigationBarTheme: getBottomNavigationBarThemeData(appTheme),
      // colorScheme: _getColorScheme(appTheme),
      appBarTheme: _getAppBarThemeData(isDark),
      textButtonTheme: _getTextButtonThemeData(appTheme),
      inputDecorationTheme: _getInputDecorationTheme(appTheme),
      outlinedButtonTheme: _getOutlinedButtonThemeData(appTheme),
      elevatedButtonTheme: _getElevatedButtonThemeData(appTheme),
      primaryColor: appTheme.appThemeColor,
      fontFamily: appTheme.typo,
    );
  }

  static AppBarTheme _getAppBarThemeData(bool isDark){
    if(isDark){
      return const AppBarTheme(
          color: CupertinoColors.darkBackgroundGray,
          elevation: 0,
          surfaceTintColor: CupertinoColors.darkBackgroundGray
      );
    }else{
      return const AppBarTheme(
          surfaceTintColor: Colors.white,
          elevation: 0,
          color: Colors.white
      );
    }
  }

  static InputDecorationTheme _getInputDecorationTheme(AppThemeModel appTheme){
    return InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: CustomTextStyle.none16_400.copyWith(
            color: const Color(0xFF535353)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: appTheme.blackWhiteColor
            )
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14,horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppTheme.borderColor
          ),
        ),
        alignLabelWithHint: true,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppTheme.borderColor
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppTheme.borderColor
          ),
        )
    );
  }

  static ElevatedButtonThemeData _getElevatedButtonThemeData(AppThemeModel appTheme){
    return ElevatedButtonThemeData(
        style: ButtonStyle(
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
            backgroundColor: MaterialStatePropertyAll(appTheme.appThemeColor),
            textStyle: MaterialStatePropertyAll(CustomTextStyle.white14_400.copyWith(
                fontFamily: appTheme.typo
            )),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)
                )
            )
        )
    );
  }

  static OutlinedButtonThemeData _getOutlinedButtonThemeData(AppThemeModel appTheme){
    return OutlinedButtonThemeData(
       style: OutlinedButton.styleFrom(
           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(4)
           ),
           foregroundColor: appTheme.blackWhiteColor,
           textStyle: CustomTextStyle.white14_400.copyWith(
               fontFamily: appTheme.typo
           ),
           side: BorderSide(
               color: appTheme.appThemeColor,
               width: 1.5
           )
       )
   );
  }

  static TextButtonThemeData _getTextButtonThemeData(AppThemeModel appTheme){
    return TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.5)),
            textStyle: MaterialStatePropertyAll(CustomTextStyle.black14_600.copyWith(
                fontFamily: appTheme.typo
            )),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)
                )
            )
        )
    );
  }

  static BottomNavigationBarThemeData getBottomNavigationBarThemeData(AppThemeModel appTheme){
    return BottomNavigationBarThemeData(
      landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
      type: BottomNavigationBarType.fixed,
      elevation: 5,
      backgroundColor: appTheme.isDarkMode ? CupertinoColors.darkBackgroundGray : null,
      showSelectedLabels: true,
      unselectedIconTheme: IconThemeData(
        color: appTheme.isDarkMode ? Colors.white : Colors.black
      ),
      selectedIconTheme: IconThemeData(
          color: appTheme.isDarkMode ? Colors.white : Colors.black
      ),
      unselectedLabelStyle: CustomTextStyle.none14_400.copyWith(color: appTheme.isDarkMode ? Colors.white : Colors.black),
      selectedLabelStyle: CustomTextStyle.none14_500.copyWith(color: appTheme.isDarkMode ? Colors.white : Colors.black),
      showUnselectedLabels: true,
      unselectedItemColor: appTheme.isDarkMode ? Colors.white : Colors.black,
      selectedItemColor: appTheme.isDarkMode ? Colors.white : Colors.black,
    );
  }

  static FloatingActionButtonThemeData getFloatingActionButtonThemeData(AppThemeModel appTheme){
    return FloatingActionButtonThemeData(
      backgroundColor: appTheme.appThemeColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
      )
    );
  }

  static SystemUiOverlayStyle getSystemUiOverlayStyle(AppThemeModel appTheme){
    if(appTheme.appTheme == 1){
      return SystemUiOverlayStyle(
        statusBarColor: CupertinoColors.black,
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: appTheme.navigationBarColor,
      );
    }else{
      return const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      );
    }
  }

}

class AppLan{

  final String lanCode;
  final String lanName;

  AppLan({this.lanCode = "en",this.lanName = "English"});

}