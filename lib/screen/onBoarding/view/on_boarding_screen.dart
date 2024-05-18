// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen/onBoarding/view
// *******************************

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/core/theme/primary_theme.dart';
import 'package:to_do/core/utils/custom_text_style.dart';
import 'package:to_do/core/utils/size_utils.dart';
import 'package:to_do/screen/onBoarding/bloc/on_boarding_bloc.dart';
import 'package:to_do/widget/primary_button_widget.dart';

import '../../../core/app/app_theme_inherit.dart';
import '../model/on_boarding_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OnBoardingBloc>().add(OnBoardingInitial(context));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<OnBoardingBloc,OnBoardingState>(
          listener: (context,state){
            _pageController.animateToPage(state.pageIndex, duration: const Duration(milliseconds: 200) , curve: Curves.linear);
          },
          builder: (context,state){
            OnBoarding item = state.item;
            return SizedBox.expand(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (_,i){
                      return _buildPageView(item);
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: !state.isLast,
                          child: TextButton(
                            onPressed: (){
                            },
                            child: Text((AppLocalizations.of(context)?.skip??"").toUpperCase()),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible: state.pageIndex != 0,
                              replacement: const SizedBox(),
                              child: TextButton(
                                onPressed: (){
                                  context.read<OnBoardingBloc>().add(OnBoardingPrevious(context));
                                },
                                child: Text((AppLocalizations.of(context)?.back??"").toUpperCase()),
                              ),
                            ),
                            PrimaryButtonWidget(
                              onTap: (){
                                context.read<OnBoardingBloc>().add(OnBoardingNext(context));
                              },
                              label: state.isLast ? (AppLocalizations.of(context)?.get_started??"").toUpperCase() : (AppLocalizations.of(context)?.next??"").toUpperCase(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        SizedBox(height: context.screenHeight*0.5+10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildIndicatorWidget(state.pageIndex,0),
                            _buildIndicatorWidget(state.pageIndex,1),
                            _buildIndicatorWidget(state.pageIndex,2)
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildIndicatorWidget(int pageIndex,int index){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: index == 1 ? 8.0 : 0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: 4,
        width: 26,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: pageIndex == index ? AppThemeIn.of(context).appThemeModel.blackWhiteColor : AppTheme.borderColor
        ),
      ),
    );
  }

  Widget _buildPageView(OnBoarding item){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: context.screenHeight*0.5,
            child: item.image != null ? Image.asset(item.image??"") : const SizedBox(),
          ),
          const SizedBox(height: 50,),
          Text(item.title??"",style: CustomTextStyle.none30_700,textAlign: TextAlign.center,),
          const SizedBox(height: 42,),
          Text(item.description??"",style: CustomTextStyle.none16_400o4,textAlign: TextAlign.center,),
          const SizedBox(height: 50,),
        ],
      ),
    );
  }
}
