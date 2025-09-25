import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/signUp/Approved_App_Screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.approvedApplicationRoute:
        return MaterialPageRoute(builder: (_) => const ApprovedAppScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
