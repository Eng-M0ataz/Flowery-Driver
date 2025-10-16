import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CustomPasswordTextFormField extends StatefulWidget {
  const CustomPasswordTextFormField({
    super.key,
    this.onChanged,
    this.validator,
    required this.controller,
    required this.hint,
    required this.label,
  });
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String hint;
  final String label;

  @override
  State<CustomPasswordTextFormField> createState() =>
      _CustomPasswordTextFormFieldState();
}

class _CustomPasswordTextFormFieldState
    extends State<CustomPasswordTextFormField> {
  bool _obscureText = true;
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscuringCharacter: AppConstants.obscuringCharacter,
      onChanged: widget.onChanged,
      obscureText: _obscureText,
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: _togglePasswordVisibility,
        ),
      ),
    );
  }
}
