import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_view_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/widgets/edit_profile_widgets/edit_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<ProfileViewModel>()..doIntend(GetLoggedDriverDataEvent()),
      child: const EditProfileForm(),
    );
  }
}
