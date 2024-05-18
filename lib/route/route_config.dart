// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/route
// *******************************

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/route/route_path.dart';
import 'package:to_do/screen/home_screen.dart';
import 'package:to_do/screen/onBoarding/on_boarding.dart';
import 'package:to_do/screen/splash/splash_screen.dart';

class RouterConfiguration{
  static RouterConfiguration? _instance;

  RouterConfiguration._();

  factory RouterConfiguration.instanceFor(){
    return _instance ??= RouterConfiguration._();
  }

  static RouterConfiguration get instance{
    return RouterConfiguration.instanceFor();
  }

  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "Root");

  GoRouter getRouter(){
    return GoRouter(
        navigatorKey: rootNavigatorKey,
        initialLocation: RouterPath.initial,
        routes: [
          GoRoute(
            path: RouterPath.initial,
            pageBuilder: (context,state){
              return _buildPageWithDefaultTransition<void>(
                context: context,
                child: const SplashScreen(),
                state: state
              );
            },
          ),
          GoRoute(
            path: RouterPath.home,
            pageBuilder: (context,state){
              return _buildPageWithDefaultTransition<void>(
                context: context,
                child: const HomeScreen(),
                state: state
              );
            },
          ),
          GoRoute(
            path: RouterPath.onBoarding,
            pageBuilder: (context,state){
              return _buildPageWithDefaultTransition<void>(
                  context: context,
                  child: const OnBoardingScreen(),
                  state: state
              );
            },
          )
          // ShellRoute(
          //   builder: (context, state, child) {
          //     return HomeScreen(state: state,child: child,);
          //   },
          //   routes: [
          //     GoRoute(
          //         path: RouterPath.initial,
          //         pageBuilder: (context,state){
          //           return buildPageWithDefaultTransition<void>(
          //               context: context,
          //               child: const ScanScreen(),
          //               state: state
          //           );
          //         },
          //         routes: [
          //           GoRoute(
          //             path: RouterPath.checkInOut,
          //             pageBuilder: (context,state){
          //               String message = state.uri.queryParameters[RouterParam.message]??"";
          //               return DialogPage(
          //                   builder: (_){
          //                     return Center(
          //                       child: Dialog(
          //                         child: Container(
          //                           decoration: BoxDecoration(
          //                               color: Colors.white,
          //                               borderRadius: BorderRadius.circular(24)
          //                           ),
          //                           child: Padding(
          //                             padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 20),
          //                             child: Column(
          //                               crossAxisAlignment: CrossAxisAlignment.center,
          //                               mainAxisSize: MainAxisSize.min,
          //                               children: [
          //                                 Lottie.asset(
          //                                   AssetsPath.astLttSuccessCheckPng,
          //                                   repeat: true,height: 80,
          //                                   width: 80,reverse: true,
          //                                 ),
          //                                 Text(message,style: CustomTextStyle.primary17_400,textAlign: TextAlign.center),
          //                                 const SizedBox(height: 10,),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                     );
          //                   },
          //                   barrierDismissible: false
          //               );
          //             },
          //           ),
          //         ]
          //     ),
          //     GoRoute(
          //       path: RouterPath.profile,
          //       pageBuilder: (context,state){
          //         return buildPageWithDefaultTransition<void>(
          //             context: context,
          //             child: const ProfileScreen(),
          //             state: state
          //         );
          //       },
          //     )
          //   ],
          // )
        ]
    );
  }

  static CustomTransitionPage _buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

}