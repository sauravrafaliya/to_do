// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen/onBoarding/bloc
// *******************************

part of 'on_boarding_bloc.dart';

class OnBoardingState extends Equatable{

  final int pageIndex;
  final OnBoarding item;
  final bool isLast;

  const OnBoardingState(this.item,[this.pageIndex = 0,this.isLast = false]);

  @override
  List<Object?> get props => [pageIndex,item,isLast];

}


