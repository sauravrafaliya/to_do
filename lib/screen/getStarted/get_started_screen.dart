// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen/getStarted
// *******************************

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/core/utils/custom_text_style.dart';
import 'package:to_do/core/utils/size_utils.dart';
import 'package:to_do/screen/home_screen.dart';
import 'package:to_do/screen/signInUp/bloc/auth_bloc.dart';
import 'package:to_do/screen/signInUp/view/sign_in_up_screen.dart';
import 'package:to_do/widget/primary_button_widget.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(appLocalizations?.welcome_uptodo??"",style: CustomTextStyle.none32_700,textAlign: TextAlign.center),
              const SizedBox(height: 26,),
              Text(appLocalizations?.login_des??"",textAlign: TextAlign.center,style: CustomTextStyle.none16_400o4),
              const Spacer(),
              PrimaryButtonWidget(
                height: 50,
                onTap: (){
                  context.read<AuthBloc>().add(AuthNavigation(context,isLogin: true));
                },
                width: context.screenWidth,
                label: (appLocalizations?.login??"").toUpperCase()
              ),
              const SizedBox(height: 28,),
              SizedBox(
                height: 50,
                width: context.screenWidth,
                child: OutlinedButton(
                    onPressed: (){
                      context.read<AuthBloc>().add(AuthNavigation(context,isLogin: false));
                    },
                    child: Text((appLocalizations?.create_account??"").toUpperCase()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
