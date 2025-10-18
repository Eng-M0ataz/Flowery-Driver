import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/core/models/order_details_model.dart';
import 'package:flowery_tracking/features/auth/presentation/pages/forget_password_screen.dart';
import 'package:flowery_tracking/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/signUp/apply_success_screen.dart';
import 'package:flowery_tracking/features/mainLayout/main_layout.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/pages/home_screen.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/pages/order_details_screen.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/pages/orders_screen.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/pages/edit_profile_screen.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/pages/profile_screen.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/pages/order_details_screen.dart';
import 'package:flowery_tracking/features/resetPassword/presentation/pages/reset_password_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case AppRoutes.mainLayoutRoute:
        return MaterialPageRoute(builder: (_) => const MainLayout());
      case AppRoutes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.ordersRoute:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case AppRoutes.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case AppRoutes.editProfileRoute:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case AppRoutes.applySuccessRoute:
        return MaterialPageRoute(builder: (_) => const ApprovedAppScreen());
      case AppRoutes.signUpRoute:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      case AppRoutes.ordersOrderDetailsRoute:
        return MaterialPageRoute(
          builder: (_) => const OrderOrderDetailsScreen(),
          settings: settings,
        );
      case AppRoutes.orderDetailsRoute:
        final orderDetailsModel = settings.arguments as OrderDetailsModel;
        return MaterialPageRoute(
          builder: (_) =>
              OrderDetailsScreen(orderDetailsModel: orderDetailsModel),
          settings: settings,
        );
      case AppRoutes.resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case AppRoutes.signInRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
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
