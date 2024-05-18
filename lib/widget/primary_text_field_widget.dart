// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/widget
// *******************************

import 'package:flutter/material.dart';
import 'package:to_do/core/app/app_theme_inherit.dart';
import 'package:to_do/core/utils/custom_text_style.dart';

class PrimaryTextFieldWidget extends StatelessWidget {
  final TextInputType textInputType;
  final String? title;
  final String? labelText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const PrimaryTextFieldWidget({
    super.key,
    this.textInputType = TextInputType.text,
    this.title,
    this.labelText,
    this.onChanged,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    bool isObscure = textInputType == TextInputType.visiblePassword;
    bool hasTextEmpty = controller?.text.isEmpty??false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title??"").isNotEmpty ? Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(title??"",style: CustomTextStyle.none16_400,),
        ) : const SizedBox(),
        TextFormField(
          initialValue: hasTextEmpty ? null : controller?.text,
          controller: hasTextEmpty ? controller : null,
          obscureText: isObscure,
          onChanged: onChanged,
          keyboardType: TextInputType.visiblePassword,
          cursorColor: AppThemeIn.of(context).appThemeModel.appThemeColor,
          style: isObscure ? const TextStyle(letterSpacing: 8) : null,
          decoration: InputDecoration(
            labelText: isObscure ? "••••••••" : labelText,
            labelStyle: isObscure ? Theme.of(context).inputDecorationTheme.labelStyle?.copyWith(
              letterSpacing: 8
            ) : null
          ),
        ),
      ],
    );
  }
}
