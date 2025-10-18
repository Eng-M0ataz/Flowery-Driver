import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_view_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/widgets/orders_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel _homeViewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _homeViewModel = getIt<HomeViewModel>();
    _homeViewModel.doIntend(GetDriverDataEvent());
    _homeViewModel.doIntend(LoadInitialOrdersEvent());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 500) {
        _homeViewModel.doIntend(LoadNextOrdersEvent());
      }
    });
  }


  @override
  void dispose() {
    _scrollController.dispose();
    _homeViewModel;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeViewModel>.value(
      value: _homeViewModel,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.spaceBetweenItems_32),
              Padding(
                padding: const EdgeInsets.only(left: AppSizes.paddingMd_16),
                child: SvgPicture.asset(
                  Assets.assetsImagesFloweryRider,
                  width: AppSizes.imageLogoWidth_113,
                  height: AppSizes.imageLogoHeight_25,
                ),
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_16),

              OrdersSection(
                homeViewModel: _homeViewModel,
                scrollController: _scrollController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
