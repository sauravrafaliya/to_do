// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/widget
// *******************************

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do/core/app/model/app_theme_model.dart';

import '../core/app/app_theme_inherit.dart';

class SvgImage extends StatelessWidget {
  final String name;
  final Color? color;
  final bool isTheme;
  final double? width;
  final double? height;
  const SvgImage(this.name, {super.key,this.color, this.isTheme = false,this.width,this.height});

  @override
  Widget build(BuildContext context) {
    AppThemeModel appTheme = AppThemeIn.of(context).appThemeModel;
    if(isTheme){
      return SvgPicture.asset(name,
        colorFilter: ColorFilter.mode(appTheme.appThemeColor, BlendMode.srcIn),
        height: height,
        width: width,
      );
    }else{
      return SvgPicture.asset(name,
        colorFilter: ColorFilter.mode(color??AppThemeIn.of(context).appThemeModel.blackWhiteColor, BlendMode.srcIn),
        height: height,
        width: width,
      );
    }
  }
}
