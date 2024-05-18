// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen/landing/bloc
// *******************************

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'landing_state.dart';
part 'landing_event.dart';

class LandingBloc extends Bloc<LandingEvent,LandingState>{

  LandingBloc() : super(const LandingInitialState()){
    on<LandingChangeTab>(_onChangeTab);
  }

  void _onChangeTab(LandingChangeTab event,Emitter<LandingState> emit){
    emit(LandingChangeTabState(event.index));
  }

}