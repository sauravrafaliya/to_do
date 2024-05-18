// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen/onBoarding/bloc
// *******************************

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/core/const/assets_path.dart';
import 'package:to_do/screen/getStarted/get_started_screen.dart';
import 'package:to_do/screen/onBoarding/on_boarding.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/screen/signInUp/view/sign_in_up_screen.dart';

part '../bloc/on_boarding_event.dart';
part '../bloc/on_boarding_state.dart';


class OnBoardingBloc extends Bloc<OnBoardingEvent,OnBoardingState>{

  OnBoardingBloc() : super(OnBoardingState(OnBoarding(), 0)){
    on<OnBoardingNext>(_nextPage);
    on<OnBoardingPrevious>(_previousPage);
    on<OnBoardingInitial>(_initialPage);
  }

  Future _nextPage(OnBoardingNext event,Emitter<OnBoardingState> emit)async{
    if(state.pageIndex < 2){
      int index = state.pageIndex+1;
      OnBoarding item = _getOnBoardingItem(event.context, index);
      bool isLast = index == 2 ? true : false;
      emit(OnBoardingState(item,index,isLast));
    }else{
      await Navigator.push(
        event.context,
        MaterialPageRoute(builder: (context) => const GetStartedScreen()),
      ).whenComplete((){
        OnBoarding item = _getOnBoardingItem(event.context, state.pageIndex);
        emit(OnBoardingState(item,state.pageIndex,true));
      });
      // event.context.go(RouterPath.home);
    }
  }

  Future _initialPage(OnBoardingInitial event,Emitter<OnBoardingState> emit)async{
    OnBoarding item = _getOnBoardingItem(event.context, 0);
    emit(OnBoardingState(item,0,false));
  }

  Future _previousPage(OnBoardingPrevious event,Emitter<OnBoardingState> emit)async{
    if(state.pageIndex != 0){
      OnBoarding item = _getOnBoardingItem(event.context, state.pageIndex-1);
      emit(OnBoardingState(item,state.pageIndex-1,false));
    }
  }

  OnBoarding _getOnBoardingItem(BuildContext context,int pageIndex){
    switch(pageIndex){
      case 0 : return OnBoarding(
        title: AppLocalizations.of(context)?.manage_task,
        description: AppLocalizations.of(context)?.manage_task_des,
        image: AssetsPath.imgManageTasksPng
      );
      case 1 : return OnBoarding(
          title: AppLocalizations.of(context)?.daily_routine,
          description: AppLocalizations.of(context)?.daily_routine_des,
          image: AssetsPath.imgDailyRoutinePng
      );
      case 2 : return OnBoarding(
          title: AppLocalizations.of(context)?.organize_task,
          description: AppLocalizations.of(context)?.organize_task_des,
          image: AssetsPath.imgOrganizeTasksPng
      );
      default: return OnBoarding();
    }
  }


}