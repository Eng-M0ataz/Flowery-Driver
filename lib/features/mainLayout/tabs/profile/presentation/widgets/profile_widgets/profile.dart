import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/helpers/routing_extensions.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/pages/edit_profile_screen.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_state.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_view_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/widgets/profile_widgets/profile_app_bar.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/widgets/profile_widgets/profile_edit_card.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/widgets/profile_widgets/profile_footer.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/widgets/profile_widgets/vehicle_edit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final ProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<ProfileViewModel>();
    viewModel.doIntend(LoadDriverDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.spaceBetweenItems_6),
            ProfileAppBar(onTap: () {}),
            BlocBuilder<ProfileViewModel, ProfileState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.failure != null) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: AppSizes.spaceBetweenItems_32),
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.paddingXl_64),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppSizes.borderRadiusMd_10),
                        border: Border.all(color: Theme
                            .of(context)
                            .colorScheme
                            .onSurface)
                    ),
                    child: Center(
                      child: Column(
                        spacing: AppSizes.spaceBetweenItems_24,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error,
                            size: AppSizes.icon_60,
                            color: AppColorsLight.red,
                          ),
                          Text(
                            state.failure!.errorMessage,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodySmall,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    ProfileEditCard(
                      onTap: () async {
                        // Navigate to second screen and wait for result
                        final shouldRefresh = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        );

                        // If we got a result and it's true, refresh data
                        if (shouldRefresh == true) {
                          viewModel.doIntend(LoadDriverDataEvent());
                        }

                      },
                      imagePath:
                      state.driverProfileResponseEntity!.driver!.photo,
                      title:
                      '${state.driverProfileResponseEntity!.driver!
                          .firstName} ${state.driverProfileResponseEntity!
                          .driver!.lastName}',
                      subtitle:
                      state.driverProfileResponseEntity!.driver!.email ??
                          '',
                      vehicleOrPhoneNumber:
                      state.driverProfileResponseEntity!.driver!.phone ??
                          '',
                    ),
                    VehicleEditCard(
                      vehicleType: state
                          .vehicleResponseEntity!.vehicle!.type ??
                          '',
                      vehicleNumber: state
                          .driverProfileResponseEntity!
                          .driver!
                          .vehicleNumber ??
                          '',
                      onTap: () {},
                    )
                  ],
                );
              },
            ),
            ProfileFooter(
              onTap: () {},
              trailing: Icons.language,
              title: LocaleKeys.language.tr(),
              leading: Icons.translate,
              isIconBtn: false,
            ),
            ProfileFooter(
              onTap: () {},
              trailing: Icons.logout,
              title: LocaleKeys.logout.tr(),
              leading: Icons.logout,
              isIconBtn: true,
            ),
          ],
        ),
      ),
    );
  }
}
