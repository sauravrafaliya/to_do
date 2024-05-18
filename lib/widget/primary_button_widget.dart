// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/widget
// *******************************

import 'package:flutter/material.dart';
import 'package:to_do/core/app/app_theme_inherit.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final Function()? onTap;
  final String? label;
  final double? width;
  final double? height;
  final bool isLoading;
  const PrimaryButtonWidget({super.key,this.label,this.onTap,this.width,this.height,this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height??48,
      child: ElevatedButton(
        style: onTap != null ? null : ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(AppThemeIn.of(context).appThemeModel.appThemeColor.withOpacity(0.4)),
          foregroundColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.7))
        ),
        onPressed: onTap,
        child: !isLoading ? Text(label??"") : const SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
      ),
    );
  }
}
