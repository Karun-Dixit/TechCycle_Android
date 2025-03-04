import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1/features/home/presentation/view_model/home_cubit.dart';
import 'package:sprint1/features/home/presentation/view_model/home_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Access the current theme
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 16),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color ??
                        Colors.black87, // Fallback for light mode
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: theme.textTheme.bodyMedium?.color ??
                            Colors.black54, // Fallback for light mode
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.green),
                      title: Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: theme.textTheme.bodyLarge?.color ??
                              Colors.black87, // Fallback for light mode
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Edit Profile coming soon')),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock, color: Colors.green),
                      title: Text(
                        'Change Password',
                        style: TextStyle(
                          color: theme.textTheme.bodyLarge?.color ??
                              Colors.black87, // Fallback for light mode
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Change Password coming soon')),
                        );
                      },
                    ),
                    const Divider(height: 32),
                    Text(
                      'Preferences',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: theme.textTheme.bodyMedium?.color ??
                            Colors.black54, // Fallback for light mode
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading:
                          const Icon(Icons.notifications, color: Colors.green),
                      title: Text(
                        'Notifications',
                        style: TextStyle(
                          color: theme.textTheme.bodyLarge?.color ??
                              Colors.black87, // Fallback for light mode
                        ),
                      ),
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Notifications toggled')),
                          );
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.brightness_6, color: Colors.green),
                      title: Text(
                        'Dark Mode',
                        style: TextStyle(
                          color: theme.textTheme.bodyLarge?.color ??
                              Colors.black87, // Fallback for light mode
                        ),
                      ),
                      trailing: Switch(
                        value: state.themeMode == ThemeMode.dark,
                        onChanged: (value) {
                          context.read<HomeCubit>().toggleTheme(value);
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                    const Divider(height: 32),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          color: theme.textTheme.bodyLarge?.color ??
                              Colors.black87, // Fallback for light mode
                          fontSize: 16,
                        ),
                      ),
                      onTap: () {
                        context.read<HomeCubit>().logout(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
