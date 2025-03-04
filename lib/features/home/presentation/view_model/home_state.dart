import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;
  final ThemeMode themeMode; // Added for dark mode

  const HomeState({
    required this.selectedIndex,
    required this.views,
    required this.themeMode,
  });

  static HomeState initial() {
    return const HomeState(
      selectedIndex: 1, // Match your default Shop tab
      views: [], // Empty since not used
      themeMode: ThemeMode.light, // Default to light mode
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
    ThemeMode? themeMode,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views, themeMode];
}
