import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/functions/validators.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signUp/sign_up_cubit.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signUp/sign_up_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleTypeDropdownButtonFormField extends StatelessWidget {
  const VehicleTypeDropdownButtonFormField({
    super.key,
    required this.onChanged,
  });
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpCubitState>(
      builder: (context, state) => DropdownButtonFormField<String>(
        isExpanded: true,
        alignment: Alignment.centerLeft,
        decoration: InputDecoration(
          labelText: LocaleKeys.vehicle_type.tr(),
          labelStyle: Theme.of(context).textTheme.labelMedium,
          suffixIcon: Icon(
            Icons.keyboard_arrow_down,
            size: AppSizes.icon_30,
            color: AppColorsLight.white[100],
          ),
        ),
        hint: Text(
          LocaleKeys.select_vehicle_type.tr(),
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(color: AppColorsLight.white[70]),
        ),
        items: state.vehicleList!
            .map(
              (e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.type, textAlign: TextAlign.center),
              ),
            )
            .toList(),
        onChanged: onChanged,
        validator: (value) => Validations.VehicleTypeValidator(value),
      ),
    );
  }
}
