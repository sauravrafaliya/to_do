// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen/landing/bloc
// *******************************

part of 'landing_bloc.dart';

sealed class LandingEvent extends Equatable{}

class LandingChangeTab extends LandingEvent{

  final int index;

  LandingChangeTab(this.index);

  @override
  List<Object?> get props => [index];

}