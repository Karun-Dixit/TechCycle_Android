import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1/features/home/presentation/bloc/home_bloc.dart';
import 'package:sprint1/features/home/presentation/view/home_view.dart';
import 'package:sprint1/features/home/presentation/view/settings_screen.dart';
import 'package:sprint1/features/home/presentation/view/wishlist_screen.dart';
import 'package:sprint1/features/home/presentation/view_model/home_cubit.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 1; // Start on Shop (Dashboard)

  static const List<Widget> _screens = [
    WishlistScreen(),
    DashboardScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('Switched to screen index: $index');
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Access the current theme
    return BlocProvider.value(
      value: BlocProvider.of<HomeCubit>(context),
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: theme.primaryColor, // Use theme primary color for selected items
          unselectedItemColor: theme.textTheme.bodyMedium?.color, // Use theme text color for unselected items
          onTap: _onItemTapped,
          backgroundColor: theme.bottomAppBarTheme.color ?? theme.scaffoldBackgroundColor, // Use theme background color
          elevation: 8,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}