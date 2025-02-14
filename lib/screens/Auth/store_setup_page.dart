import 'package:craftify_vendor/common/button.dart';
import 'package:craftify_vendor/screens/Auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class StoreSetupPage extends StatelessWidget {
  const StoreSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header Section
                Text(
                  "Craftihub",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan[900],
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  "Hello, Seller",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.cyan[700],
                  ),
                ),
                SizedBox(height: 2.5.h),

                // Verification Pending Card
                // if (authProvider.isBioSetUp)
                  _buildCard(
                    icon: Icons.verified_user,
                    title: "Verification Pending",
                    subtitle: "Please verify your contact details",
                    buttonText: "Verify Now",
                  ),
                SizedBox(height: 2.5.h),

                // Profile Setup Card
                _buildProfileSetupCard(authProvider),
                SizedBox(height: 40),

                // Get Started Button
                customButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    buttonName: 'Get Started',
                    color: Colors.cyan),
                SizedBox(height: 1.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.cyan),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.cyan[700]),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan[900],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            customRoundButton(
              onPressed: () {},
              textWidget: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSetupCard(AuthProvider authProvider) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, size: 40, color: Colors.cyan[700]),
                SizedBox(width: 16),
                Text(
                  "Complete Your Profile",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildProfileStep("Set up your Bio", false),
            _buildProfileStep("Set up your store", false),
            _buildProfileStep("Finish", false),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStep(String text, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? Colors.cyan[700] : Colors.grey[400],
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isCompleted ? Colors.cyan[900] : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
