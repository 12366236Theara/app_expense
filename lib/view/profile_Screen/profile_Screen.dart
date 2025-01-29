import 'package:app_cating/token/toekn.dart';
import 'package:app_cating/view/onBoarding_Screen/onBoarding_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple, // Darker app bar color
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            children: [
              // Profile Header Section
              Column(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/images/profile_placeholder.png'), // Replace with actual profile image
                  ),
                  const SizedBox(height: 16.0),
                  // User Name
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Email
                  const Text(
                    'john.doe@example.com',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              // Profile Options
              Padding(
                padding: const EdgeInsets.only(right: 16 , left: 16 , top: 16),
                child: Column(
                  children: [
                    _buildProfileOption(
                      icon: Icons.account_circle,
                      title: 'Edit Profile',
                      onTap: () {
                        // Navigate to edit profile screen
                      },
                    ),
                    const Divider(height: 1),
                    _buildProfileOption(
                      icon: Icons.lock,
                      title: 'Change Password',
                      onTap: () {
                        // Navigate to change password screen
                      },
                    ),
                    const Divider(height: 1),
                    _buildProfileOption(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      onTap: () {
                        // Navigate to notifications settings
                      },
                    ),
                    const Divider(height: 1),
                    _buildProfileOption(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () {
                        // Navigate to help & support
                      },
                    ),
                    const Divider(height: 1),
                    _buildProfileOption(
                      icon: Icons.logout,
                      title: 'Logout',
                      onTap: () {
                        Toekn.removeToken();
                        Get.offAll(OnboardingScreen());
                        // Handle logout functionality
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
