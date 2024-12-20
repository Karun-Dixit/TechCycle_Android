import 'package:flutter/material.dart';

import 'dashboard_screen.dart'; // Import your DashboardScreen
import 'wishlist_screen.dart'; // Import your WishlistScreen

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example Profile Content
            const CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage('assets/images/profile.png'), // Profile image
            ),
            const SizedBox(height: 16),
            const Text(
              'John Doe', // User name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'john.doe@example.com', // User email
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // You can add profile editing functionality here
              },
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar with navigation functionality
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Highlight the Profile tab
        onTap: (index) {
          // Handle tab selection and navigation
          if (index == 0) {
            // Navigate to Dashboard screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          } else if (index == 1) {
            // Navigate to Wishlist screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WishlistScreen()),
            );
          } else if (index == 2) {
            // Stay on Profile screen (no navigation)
          }
        },
        selectedItemColor: Colors.green, // Active tab color
        unselectedItemColor: Colors.grey, // Inactive tab color
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
