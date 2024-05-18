// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen/landing/bloc
// *******************************

part of 'landing_bloc.dart';

abstract class LandingState extends Equatable {

  final int index;

  const LandingState(this.index);

  @override
  List<Object?> get props => [index];

}

class LandingChangeTabState extends LandingState{

  const LandingChangeTabState(super.index);

}

class LandingInitialState extends LandingState{

  const LandingInitialState() : super(0);

}