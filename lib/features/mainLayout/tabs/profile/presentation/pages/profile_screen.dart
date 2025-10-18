import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_view_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/widgets/profile_widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> getIt.get<ProfileViewModel>()..doIntend(GetLoggedDriverDataEvent()),
    child: const Profile(),
    );
  }
}
