import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class CountryTextFormField extends StatelessWidget {
  const CountryTextFormField({
    super.key,
    required this.onChanged,
    required this.onInit,
  });
  final void Function(CountryCode)? onChanged;
  final Function(CountryCode?)? onInit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        prefixIcon: CountryCodePicker(
          onChanged: onChanged,
          showCountryOnly: true,
          initialSelection: 'EG',
          onInit: onInit,
          showOnlyCountryWhenClosed: true,
          alignLeft: true,
          flagWidth: 24,
          hideSearch: true,
          padding: EdgeInsetsGeometry.zero,
        ),
      ),
    );
  }
}
