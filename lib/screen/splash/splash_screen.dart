// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen/splash
// *******************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/core/const/assets_path.dart';
import 'package:to_do/core/const/const_string.dart';
import 'package:to_do/core/utils/custom_text_style.dart';
import 'package:to_do/route/route_path.dart';
import 'package:to_do/screen/landing/view/landing_screen.dart';
import 'package:to_do/screen/onBoarding/on_boarding.dart';
import 'package:to_do/widget/svg_image_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(FirebaseAuth.instance.currentUser != null){
        Future.delayed(const Duration(seconds: 1),(){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LandingScreen()),
          );
          // context.go(RouterPath.onBoarding);
        });
      }else{
        Future.delayed(const Duration(seconds: 1),(){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
          );
          // context.go(RouterPath.onBoarding);
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SvgImage(AssetsPath.icToDoSvg,isTheme: true),
            const SizedBox(height: 35,),
            Text(upToDo,style: CustomTextStyle.none40_700,)
          ],
        ),
      ),
    );
  }
}
