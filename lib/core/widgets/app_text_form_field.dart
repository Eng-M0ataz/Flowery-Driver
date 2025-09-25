import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatefulWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final String hintText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final String? labelText;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  bool isObscureText;

  AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.labelStyle,
    this.labelText,
    required this.isPassword,
    required this.hintText,
    this.isObscureText = true,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    this.validator,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscuringCharacter: '*',
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: widget.labelStyle ?? const TextStyle(color: AppColorsLight.black),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? const TextStyle(color: AppColorsLight.grey),
        isDense: true,
        contentPadding:
        widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_20, vertical:  AppSizes.paddingMd_18),
        focusedBorder:
        widget.focusedBorder ??
            OutlineInputBorder(
              borderSide:  const BorderSide(width: AppSizes.borderWidth_1),
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),
            ),
        enabledBorder:
        widget.enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: AppColorsLight.grey, width: AppSizes.borderWidth_1),
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: AppSizes.borderWidth_1),
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: AppSizes.borderWidth_1),
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
          onPressed: () {
            widget.isObscureText = !widget.isObscureText;
            setState(() {});
          },
          icon: Icon(
            widget.isObscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColorsLight.grey,
          ),
        )
            : widget.suffixIcon,
        fillColor: widget.backgroundColor,
        filled: true,
      ),
      obscureText: widget.isPassword ? widget.isObscureText : false,
      style: const TextStyle(fontSize: AppSizes.smFont_14),
      validator: widget.validator,
    );
  }
}
