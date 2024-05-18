// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/core/app/bloc/app_bloc.dart
// *******************************

part of 'app_bloc.dart';

sealed class AppThemeEvent extends Equatable{}

class AppThemeInitialEvent extends AppThemeEvent{

  @override
  List<Object?> get props => [];

}

class AppThemeSetColorEvent extends AppThemeEvent{
  final String? appColor;

  AppThemeSetColorEvent({this.appColor});

  @override
  List<Object?> get props => [appColor];

}

class AppThemeSetThemeModeEvent extends AppThemeEvent{
  final int? themMode;

  AppThemeSetThemeModeEvent({this.themMode});

  @override
  List<Object?> get props => [themMode];

}

class AppThemeSetFontFamilyEvent extends AppThemeEvent{
  final String? fontFamily;

  AppThemeSetFontFamilyEvent({this.fontFamily});

  @override
  List<Object?> get props => [fontFamily];

}

class AppThemeSetLocalEvent extends AppThemeEvent{
  final String? local;

  AppThemeSetLocalEvent({this.local});

  @override
  List<Object?> get props => [local];

}

class AppThemeSetDarkGreyBottomBarEvent extends AppThemeEvent{

  AppThemeSetDarkGreyBottomBarEvent();

  @override
  List<Object?> get props => [];

}

class AppThemeSetBlackBottomBarEvent extends AppThemeEvent{

  AppThemeSetBlackBottomBarEvent();

  @override
  List<Object?> get props => [];

}
