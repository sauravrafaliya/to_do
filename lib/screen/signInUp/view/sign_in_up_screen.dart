// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen/signInUp/view
// *******************************

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/core/app/app_theme_inherit.dart';
import 'package:to_do/core/const/assets_path.dart';
import 'package:to_do/core/utils/custom_text_style.dart';
import 'package:to_do/core/utils/helper_fun.dart';
import 'package:to_do/core/utils/size_utils.dart';
import 'package:to_do/screen/signInUp/bloc/auth_bloc.dart';
import 'package:to_do/screen/signInUp/model/auth_bloc_model.dart';
import 'package:to_do/widget/primary_button_widget.dart';
import 'package:to_do/widget/primary_text_field_widget.dart';
import 'package:to_do/widget/svg_image_widget.dart';

class SignInUpScreen extends StatelessWidget {
  const SignInUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? appLocalizations = AppLocalizations.of(context);
    final authBloc = context.read<AuthBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc,AuthState>(
        listener: (context,state){
          if(state is AuthError){
            HelperFun.buildSnackBar(context, state.authBlocModel?.message??"");
          }
        },
        builder: (context,state){
          AuthBlocModel authBlocModel = state.authBlocModel??AuthBlocModel();
          bool isLogin = authBlocModel.isLogin;
          return SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(isLogin ? appLocalizations?.login??"" :  appLocalizations?.register??"",style: CustomTextStyle.none30_700,)),
                    const SizedBox(height: 24,),
                    PrimaryTextFieldWidget(
                      controller: authBlocModel.email,
                      onChanged: (email){
                        authBloc.add(AuthEmailChanged(email));
                      },
                      title: appLocalizations?.username,
                      labelText: appLocalizations?.enter_your_username,
                    ),
                    const SizedBox(height: 24,),
                    PrimaryTextFieldWidget(
                      controller: authBlocModel.password,
                      title: appLocalizations?.password,
                      textInputType: TextInputType.visiblePassword,
                      onChanged: (password){
                        authBloc.add(AuthPasswordChanged(password));
                      },
                    ),
                    Visibility(
                      visible: !isLogin,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: PrimaryTextFieldWidget(
                          controller: authBlocModel.confirmPassword,
                          onChanged: (password){
                            authBloc.add(AuthConfirmPasswordChanged(password));
                          },
                          title: appLocalizations?.confirm_password,
                          textInputType: TextInputType.visiblePassword,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40,),
                    PrimaryButtonWidget(
                      onTap: authBlocModel.isValid ? (){
                        authBloc.add(AuthSignInUp(context));
                      } : null,
                      isLoading: authBlocModel.isLoading,
                      width: context.screenWidth,
                      label: isLogin ? appLocalizations?.login : appLocalizations?.register
                    ),
                    const SizedBox(height: 24,),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(appLocalizations?.or??""),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 24,),
                    _buildSocialButton(
                      context,
                      icon: AssetsPath.icGoogleSvg,
                      label: isLogin ? appLocalizations?.login_with_google : appLocalizations?.register_with_google,
                      onTap: (){
                        authBloc.add(AuthGoogleSignIn(context));
                      }
                    ),
                    const SizedBox(height: 18,),
                    _buildSocialButton(
                      context,
                      icon: AssetsPath.icAppleSvg,
                      label: isLogin ? appLocalizations?.login_with_apple : appLocalizations?.register_with_apple,
                    ),
                    const SizedBox(height: 50,),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: isLogin ? appLocalizations?.not_have_an_account : appLocalizations?.have_account,
                            style: CustomTextStyle.grey12_400.copyWith(
                                fontFamily: AppThemeIn.of(context).appThemeModel.typo
                            ),
                            children: [
                              const TextSpan(text: "  ",),
                              TextSpan(
                                  recognizer: TapGestureRecognizer()..onTap = ()async{
                                    authBloc.add(const AuthChangedMode());
                                  },
                                  text: "${isLogin ? appLocalizations!.register : appLocalizations?.login}",
                                  style: CustomTextStyle.none12_400.copyWith(
                                      color: AppThemeIn.of(context).appThemeModel.blackWhiteColor,
                                      decoration: TextDecoration.underline
                                  )
                              )
                            ]
                        )
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSocialButton(BuildContext context,{String? icon,String? label,Function()? onTap}){
    return SizedBox(
      width: context.screenWidth,
      height: 48,
      child: OutlinedButton(
          onPressed: onTap,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: CustomTextStyle.none16_400.copyWith(
                    fontFamily: AppThemeIn.of(context).appThemeModel.typo,
                  color: AppThemeIn.of(context).appThemeModel.blackWhiteColor
                ),
                children: [
                  WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SvgImage(icon??"")),
                  TextSpan(
                      text: "   ${label??""}"
                  )
                ]
            ),
          )
      ),
    );
  }
}
