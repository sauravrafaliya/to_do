// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/core/app/bloc/app_bloc.dart
// *******************************

import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/app_theme_model.dart';

part 'app_state.dart';
part 'app_event.dart';

class AppThemeBloc extends Bloc<AppThemeEvent,AppThemeState>{

  AppThemeBloc() : super(AppThemeInitialState()){
    on<AppThemeSetColorEvent>(_loadAppThemeColor);
    on<AppThemeInitialEvent>(_loadInitialAppTheme);
    on<AppThemeSetThemeModeEvent>(_loadAppThemeMode);
    on<AppThemeSetLocalEvent>(_loadAppLan);
    on<AppThemeSetFontFamilyEvent>(_loadAppFontFamily);
    on<AppThemeSetBlackBottomBarEvent>(_loadAppBlackBottomBar);
    on<AppThemeSetDarkGreyBottomBarEvent>(_loadAppDarkGreyBottomBar);
  }

  Future _loadAppThemeColor(AppThemeSetColorEvent event,Emitter<AppThemeState> emit)async{
    try{
      if(state is AppThemeSuccessState){
        emit(AppThemeSuccessState(appTheme: (state as AppThemeSuccessState).appTheme?.copyWith(
          appColor: event.appColor
        )));
      }else{
        emit(AppThemeSuccessState(appTheme: AppThemeModel()));
      }
    }catch(_){
      emit(AppThemeErrorState());
    }
  }

  Future _loadAppThemeMode(AppThemeSetThemeModeEvent event,Emitter<AppThemeState> emit)async{
    try{
      if(state is AppThemeSuccessState){
        emit(AppThemeSuccessState(appTheme: (state as AppThemeSuccessState).appTheme?.copyWith(
            appTheme: event.themMode
        )));
      }else{
        emit(AppThemeSuccessState(appTheme: AppThemeModel()));
        add(AppThemeSetBlackBottomBarEvent());
      }
    }catch(_){
      emit(AppThemeErrorState());
    }
  }

  Future _loadAppFontFamily(AppThemeSetFontFamilyEvent event,Emitter<AppThemeState> emit)async{
    try{
      if(state is AppThemeSuccessState){
        emit(AppThemeSuccessState(appTheme: (state as AppThemeSuccessState).appTheme?.copyWith(
            typo: event.fontFamily
        )));
      }else{
        emit(AppThemeSuccessState(appTheme: AppThemeModel()));
      }
    }catch(_){
      emit(AppThemeErrorState());
    }
  }

  Future _loadAppLan(AppThemeSetLocalEvent event,Emitter<AppThemeState> emit)async{
    try{
      if(state is AppThemeSuccessState){
        emit(AppThemeSuccessState(appTheme: (state as AppThemeSuccessState).appTheme?.copyWith(
            appLan: event.local
        )));
      }else{
        emit(AppThemeSuccessState(appTheme: AppThemeModel()));
      }
    }catch(_){
      emit(AppThemeErrorState());
    }
  }

  Future _loadAppDarkGreyBottomBar(AppThemeSetDarkGreyBottomBarEvent event,Emitter<AppThemeState> emit)async{
    try{
      if(state is AppThemeSuccessState){
        AppThemeModel appThemeModel = (state as AppThemeSuccessState).appTheme??AppThemeModel();
        emit(AppThemeSuccessState(appTheme: appThemeModel.copyWith(
            navigationBarColor: appThemeModel.isDarkMode ? CupertinoColors.darkBackgroundGray : Colors.white
        )));
      }else{
        emit(AppThemeSuccessState(appTheme: AppThemeModel()));
      }
    }catch(_){
      emit(AppThemeErrorState());
    }
  }

  Future _loadAppBlackBottomBar(AppThemeSetBlackBottomBarEvent event,Emitter<AppThemeState> emit)async{
    try{
      if(state is AppThemeSuccessState){
        AppThemeModel appThemeModel = (state as AppThemeSuccessState).appTheme??AppThemeModel();
        emit(AppThemeSuccessState(appTheme: appThemeModel.copyWith(
          navigationBarColor: appThemeModel.isDarkMode ? Colors.black : Colors.white
        )));
      }else{
        emit(AppThemeSuccessState(appTheme: AppThemeModel()));
      }
    }catch(_){
      emit(AppThemeErrorState());
    }
  }

  Future _loadInitialAppTheme(AppThemeInitialEvent event,Emitter<AppThemeState> emit)async{
    try{
      bool isDark = SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
      AppThemeModel appThemeModel = AppThemeModel();
      if(isDark){
        appThemeModel.copyWith(
          appTheme: 1
        );
      }
      emit(AppThemeSuccessState(appTheme: AppThemeModel()));
    }catch(_){
      emit(AppThemeErrorState());
    }
  }


}