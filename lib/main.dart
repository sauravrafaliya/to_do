import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do/core/app/bloc/app_bloc.dart';
import 'package:to_do/core/config/initial_config.dart';
import 'package:to_do/core/theme/primary_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/domain/repository/auth_repository.dart';
import 'package:to_do/screen/landing/bloc/landing_bloc.dart';
import 'package:to_do/screen/onBoarding/bloc/on_boarding_bloc.dart';
import 'package:to_do/screen/signInUp/bloc/auth_bloc.dart';
import 'package:to_do/screen/splash/splash_screen.dart';

import 'core/app/app_theme_inherit.dart';
import 'core/app/model/app_theme_model.dart';
import 'domain/repository/user_repository.dart';

void main() async {
  await InitialConfig.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (_) => AppThemeBloc()..add(AppThemeInitialEvent())),
        BlocProvider( create: (_) => OnBoardingBloc()),
        BlocProvider( create: (_) => AuthBloc(
          authRepository: GetIt.instance.get<AuthRepository>(),
          userRepository: GetIt.instance.get<UserRepository>()
        )),
        BlocProvider( create: (_) => LandingBloc()),
      ],
      child: BlocBuilder<AppThemeBloc,AppThemeState>(
        builder: (context,state){
          AppThemeModel appTheme = AppThemeModel();
          if(state is AppThemeSuccessState){
             appTheme = state.appTheme??AppThemeModel();
          }
          return AppThemeIn(
            appThemeModel: appTheme,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: AppTheme.getSystemUiOverlayStyle(appTheme),
              child: MaterialApp(
                home: const SplashScreen(),
                // routerConfig: RouterConfiguration.instance.getRouter(),
                debugShowCheckedModeBanner: false,
                title: 'UpTodo',
                theme: AppTheme.getLightTheme(appTheme),
                darkTheme: AppTheme.getDarkTheme(appTheme),
                locale: appTheme.appLocal,
                themeMode: appTheme.appThemeMode,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
              ),
            ),
          );
        },
      ),
    );
  }
}

// child: BlocBuilder<AppThemeBloc,AppThemeState>(
//         builder: (context,state){
//           if(state is AppThemeSuccessState){
//             AppThemeModel appTheme = state.appTheme??AppThemeModel();
//             return AppThemeIn(
//               appThemeModel: appTheme,
//               child: AnnotatedRegion<SystemUiOverlayStyle>(
//                 value: AppTheme.getSystemUiOverlayStyle(appTheme),
//                 child: MaterialApp.router(
//                   routerConfig: RouterConfiguration.instance.getRouter(),
//                   debugShowCheckedModeBanner: false,
//                   title: 'Todo',
//                   theme: AppTheme.getLightTheme(appTheme),
//                   darkTheme: AppTheme.getDarkTheme(appTheme),
//                   locale: appTheme.appLocal,
//                   themeMode: appTheme.appThemeMode,
//                   localizationsDelegates: AppLocalizations.localizationsDelegates,
//                   supportedLocales: AppLocalizations.supportedLocales,
//                 ),
//               ),
//             );
//           }else{
//             bool isDark = SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
//             return MaterialApp(
//               debugShowCheckedModeBanner: false,
//               theme: ThemeData(
//                   useMaterial3: true,
//               ),
//               themeMode: ThemeMode.dark,
//               darkTheme: isDark ? ThemeData(
//                 brightness: Brightness.dark
//               ) : null,
//               home: const Scaffold(),
//             );
//           }
//         },
//       ),
