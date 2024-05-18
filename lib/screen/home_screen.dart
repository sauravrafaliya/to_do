// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/screen
// *******************************

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/core/app/app_theme_inherit.dart';
import 'package:to_do/core/app/bloc/app_bloc.dart';
import 'package:to_do/core/app/model/app_theme_model.dart';
import 'package:to_do/core/utils/color_extension.dart';
import 'package:to_do/widget/primary_text_field_widget.dart';

import '../core/theme/primary_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.count(1)??""),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 300,
            maxWidth: 400,
          ),
          child: SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PrimaryTextFieldWidget(
                      title: "Username",
                      labelText: "Enter user name",
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(height: 16,),
                    const PrimaryTextFieldWidget(
                      title: "Password",
                      textInputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 16,),
                    Text("App Color : ${AppThemeIn.of(context).appThemeModel.appColor}"),
                    const SizedBox(height: 16,),
                    GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1
                      ),
                      children: AppTheme.colors.map((e) => InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          context.read<AppThemeBloc>().add(AppThemeSetColorEvent(
                              appColor: e
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: e.toColor()
                          ),
                        ),
                      )).toList(),
                    ),
                    const SizedBox(height: 16,),
                    Text("App Fonts : ${AppThemeIn.of(context).appThemeModel.typo}"),
                    const SizedBox(height: 16,),
                    GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 3
                      ),
                      children: AppTheme.fonts.map((e) => ElevatedButton(
                        style: ButtonStyle(
                           backgroundColor: AppThemeIn.of(context).appThemeModel.typo == e ? MaterialStatePropertyAll(AppThemeIn.of(context).appThemeModel.appThemeColor) : null,
                           foregroundColor: AppThemeIn.of(context).appThemeModel.typo == e ? const MaterialStatePropertyAll(Colors.white) : null
                        ),
                        onPressed: (){
                          context.read<AppThemeBloc>().add(AppThemeSetFontFamilyEvent(
                              fontFamily: e
                          ));
                        },
                        child: Text(
                            e,style: TextStyle(fontFamily: e),
                        ),
                      )).toList(),
                    ),
                    const SizedBox(height: 16,),
                    Row(
                      children: [
                        const Expanded(child: Text("App Theme")),
                        BlocBuilder<AppThemeBloc,AppThemeState>(
                            builder: (context,state){
                              if(state is AppThemeSuccessState){
                                AppThemeModel theme = state.appTheme??AppThemeModel();
                                return Switch(
                                    value: theme.appTheme == 1,
                                    onChanged: (value){
                                      context.read<AppThemeBloc>().add(AppThemeSetThemeModeEvent(
                                          themMode: value ? 1 : 0
                                      ));
                                    }
                                );
                              }else{
                                return const SizedBox();
                              }
                            }
                        )
                      ],
                    ),
                    const SizedBox(height: 16,),
                    Text("App Languages : ${AppThemeIn.of(context).appThemeModel.appLan}"),
                    const SizedBox(height: 16,),
                    GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 2
                      ),
                      children: AppTheme.languages.map((e) => ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: AppThemeIn.of(context).appThemeModel.appLan == e.lanCode ? MaterialStatePropertyAll(AppThemeIn.of(context).appThemeModel.appThemeColor) : null,
                            foregroundColor: AppThemeIn.of(context).appThemeModel.appLan == e.lanCode ? const MaterialStatePropertyAll(Colors.white) : null
                        ),
                        onPressed: (){
                          context.read<AppThemeBloc>().add(AppThemeSetLocalEvent(
                              local: e.lanCode
                          ));
                        },
                        child: Text(
                            e.lanName
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


