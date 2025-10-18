import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/core/config/routing/route_generator.dart';
import 'package:flowery_tracking/core/config/theme/app_theme.dart';
import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/core/functions/execute_navigation.dart';
import 'package:flowery_tracking/core/helpers/app_config_cubit.dart';
import 'package:flowery_tracking/core/helpers/block_observer.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();
  final initialRoute = await getInitialRoute();
  Bloc.observer = MyBlocObserver();


  runApp(
    EasyLocalization(
      supportedLocales: AppConstants.supportedLocales,
      path: AppConstants.assetsPath,
      fallbackLocale: const Locale(AppConstants.en),
      child: FloweryDirver(initialRoute: initialRoute),
    ),
  );
}

class FloweryDirver extends StatelessWidget {
  const FloweryDirver({super.key, required this.initialRoute});
  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppConfigCubit>()..loadSavedLocale(),
      child: BlocBuilder<AppConfigCubit, Locale>(
        builder: (context, localeState) {
          return ResponsiveBreakpoints.builder(
            breakpoints: AppSizes.appBreakPoints,
            breakpointsLandscape: AppSizes.appLandscapeBreakPoints,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: localeState,
              theme: AppThemeLight.lightTheme,
              onGenerateRoute: RouteGenerator.getRoute,
              builder: (context, child) => ResponsiveScaledBox(
                width: ResponsiveValue<double>(
                  context,
                  conditionalValues: AppSizes.conditionalValues,
                ).value,
                child: child!,
              ),
              initialRoute: AppRoutes.onboardingRoute,
            ),
          );
        },
      ),
    );
  }
}
