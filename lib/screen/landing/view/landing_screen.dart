// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen/landing/view
// *******************************

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/core/app/bloc/app_bloc.dart';
import 'package:to_do/core/const/assets_path.dart';
import 'package:to_do/screen/home_screen.dart';
import 'package:to_do/screen/landing/bloc/landing_bloc.dart';
import 'package:to_do/widget/primary_button_widget.dart';
import 'package:to_do/widget/svg_image_widget.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AppThemeBloc>().add(AppThemeSetDarkGreyBottomBarEvent());
    });
    return Scaffold(
      body: Center(
        child: PrimaryButtonWidget(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
          label: "Go To Theme",
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(CupertinoIcons.add),
      ),
      bottomNavigationBar: BlocBuilder<LandingBloc,LandingState>(
        builder: (context,state){
          return SizedBox(
            height: 70,
            child: BottomNavigationBar(
              onTap: (index){
                if(index != 2){
                  context.read<LandingBloc>().add(LandingChangeTab(index));
                }
              },
              currentIndex: state.index,
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SvgImage(state.index == 0 ? AssetsPath.icHomeFillSvg : AssetsPath.icHomeSvg,height: 24,width: 24),
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                     padding: const EdgeInsets.only(bottom: 8.0),
                    child: SvgImage(state.index == 1 ? AssetsPath.icCalendarFillSvg : AssetsPath.icCalendarSvg,height: 24,width: 24),
                  ),
                  label: "Calendar",
                ),
                const BottomNavigationBarItem(
                  icon: SizedBox(),label: "",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                     padding: const EdgeInsets.only(bottom: 8.0),
                    child: SvgImage(state.index == 3 ? AssetsPath.icClockFillSvg : AssetsPath.icClockSvg,height: 24,width: 24),
                  ),
                  label: "Focus",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                     padding: const EdgeInsets.only(bottom: 8.0),
                    child: SvgImage(state.index == 4 ? AssetsPath.icProfileFillSvg : AssetsPath.icProfileSvg,height: 24,width: 24),
                  ),
                  label: "Profile",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
