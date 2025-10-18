import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/pages/home_screen.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/pages/orders_screen.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/pages/profile_screen.dart';
import 'package:flowery_tracking/features/mainLayout/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onChanged: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
