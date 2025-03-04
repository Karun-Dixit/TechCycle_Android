import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1/features/home/presentation/view_model/home_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 16),
            child: const Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // Settings List
          Expanded(
            child: ListView(
              children: [
                // Account Section
                const Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.green),
                  title: const Text('Edit Profile'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Navigate to edit profile screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Edit Profile coming soon')),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.lock, color: Colors.green),
                  title: const Text('Change Password'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Navigate to change password screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Change Password coming soon')),
                    );
                  },
                ),
                const Divider(height: 32),
                // Preferences Section
                const Text(
                  'Preferences',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Icons.notifications, color: Colors.green),
                  title: const Text('Notifications'),
                  trailing: Switch(
                    value: true, // Replace with actual state if managed
                    onChanged: (value) {
                      // TODO: Toggle notifications
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Notifications toggled')),
                      );
                    },
                    activeColor: Colors.green,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.brightness_6, color: Colors.green),
                  title: const Text('Dark Mode'),
                  trailing: Switch(
                    value: false, // Replace with actual theme state
                    onChanged: (value) {
                      // TODO: Toggle theme
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Theme toggle coming soon')),
                      );
                    },
                    activeColor: Colors.green,
                  ),
                ),
                const Divider(height: 32),
                // Logout
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
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
  }
}