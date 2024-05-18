// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen/onBoarding/bloc
// *******************************

part of 'on_boarding_bloc.dart';

sealed class OnBoardingEvent extends Equatable{
  final BuildContext context;

  const OnBoardingEvent(this.context);

}

class OnBoardingInitial extends OnBoardingEvent{

  const OnBoardingInitial(super.context);

  @override
  List<Object?> get props => [];

}

class OnBoardingNext extends OnBoardingEvent{

  const OnBoardingNext(super.context);

  @override
  List<Object?> get props => [];

}

class OnBoardingPrevious extends OnBoardingEvent{

  const OnBoardingPrevious(super.context);

  @override
  List<Object?> get props => [];

}