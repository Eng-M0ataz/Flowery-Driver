import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/pages/home_screen.dart';
import 'package:flowery_tracking/features/pickupLocation/presentation/pages/delivery_map_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.DeliveryMapRoute:
        return MaterialPageRoute(builder: (_) => const CustomMapScreen());
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
