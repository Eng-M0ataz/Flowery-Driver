import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/core/functions/snack_bar.dart';
import 'package:flowery_tracking/core/widgets/custom_app_bar.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_state.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditVehicleScreen extends StatefulWidget {
  const EditVehicleScreen({super.key});

  @override
  State<EditVehicleScreen> createState() => _EditVehicleScreenState();
}

class _EditVehicleScreenState extends State<EditVehicleScreen> {
  late final ProfileViewModel _profileViewModel;


  @override
  void initState() {
    super.initState();
    _profileViewModel = getIt<ProfileViewModel>();
    _profileViewModel.doIntend(GetAllVehiclesEvent());
    _profileViewModel.doIntend(GetDriverDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileViewModel>(
      create: (context) => _profileViewModel,
      child: Scaffold(
        appBar: CustomAppBar(title: 'Edit profile'),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocConsumer<ProfileViewModel, ProfileState>
                (
                listener: (context, state){
                  if(state.failure != null){
                    showSnackBar(
                      context: context,
                      message: state.failure!.errorMessage,
                      textStyle: TextStyle(color: Theme.of(context).colorScheme.primary)
                    );
                  }
                },
                builder: (context, state) {
                  final vehicles = state.getAllVehiclesResponseEntity!.vehicles;
                  final driver = state.getDriverDataResponseEntity?.driver;
                  if(vehicles == null || driver == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          initialValue: _profileViewModel.getDriverVehicleNameById(
                              driver.Id,
                              vehicles,
                          ),
                          items: vehicles.map((vehicle) {
                            return DropdownMenuItem<String>(
                              value: vehicle.type,
                              child: Text(vehicle.type ?? ''),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if(value != null) {
                              context.read<ProfileViewModel>().state.copyWith(
                                selectedVehicle: value
                              );
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Vehicle Type',
                            border: OutlineInputBorder(),
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
