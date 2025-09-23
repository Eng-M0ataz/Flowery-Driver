import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Size? size;
  final Color? backgroundColorButton;
  final void Function()? onPressed;
  final Widget? child;
  final double? elevation;
  final BorderSide? borderSide;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    this.size,
    this.elevation,
    this.borderSide,
    required this.child,
    this.backgroundColorButton,
    this.borderRadius = 0,
    required this.onPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        side: borderSide,
        backgroundColor: backgroundColorButton,
        minimumSize: size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(
            borderRadius,
          ),
        ),
        elevation: elevation,
      ),
      child: child,
    );
  }
}
