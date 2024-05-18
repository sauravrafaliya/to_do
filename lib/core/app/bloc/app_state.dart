// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/core/app/bloc/app_bloc.dart
// *******************************


part of 'app_bloc.dart';

sealed class AppThemeState extends Equatable{}

class AppThemeInitialState extends AppThemeState{

  @override
  List<Object?> get props => [];
}

class AppThemeLoadingState extends AppThemeState{

  @override
  List<Object?> get props => [];

}

class AppThemeErrorState extends AppThemeState{
  @override
  List<Object?> get props => [];
}

class AppThemeSuccessState extends AppThemeState{
  final AppThemeModel? appTheme;

  AppThemeSuccessState({this.appTheme});

  @override
  List<Object?> get props => [appTheme];
}

