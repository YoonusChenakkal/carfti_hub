import 'package:craftify_vendor/common/button.dart';
import 'package:craftify_vendor/const/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:craftify_vendor/screens/profile/model/provider/profile_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final user = profileProvider.user;

    // Check if user data is null
    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'No profile data available',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Banner with Dark Overlay
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: double.infinity,
                    height: 24.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(user.displayImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Subtle Bottom Gradient Overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            const Color.fromARGB(69, 91, 91, 91)
                          ],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          stops: [0.2, 1], // Adjusts where the gradient starts
                        ),
                      ),
                    ),
                  ),

                  // Store Icon (Floating)
                  Positioned(
                    bottom: 10,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(Icons.store, color: Colors.white, size: 40),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Vendor Name
              Text(
                user.name,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 1.5.h),
              // Enable/Disable Switch
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Enable Account',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Switch(
                      value: true,
                      activeColor: Colors.green,
                      onChanged: (bool value) {
                        // Implement enable/disable functionality
                      },
                    ),
                  ],
                ),
              ),

              // Information Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 4,
                  color: const Color.fromARGB(255, 252, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _infoRow(Icons.email, 'Email', user.email),
                        _infoRow(Icons.phone, 'Contact', user.contactNumber),
                        _infoRow(Icons.chair, 'WhatsApp', user.whatsappNumber),
                        _infoRow(Icons.verified, 'Approved',
                            user.isApproved ? 'Yes' : 'No'),
                        _infoRow(
                          Icons.access_time,
                          'Created',
                          DateFormat('dd.MM.yyyy').format(
                            DateTime.parse(
                                user.createdAt), // Convert string to DateTime
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3.h),

              customButton(
                  onPressed: () {
                    LocalStorage.clearUser();
                    Navigator.popAndPushNamed(context, '/login');
                  },
                  buttonName: 'Log Out',
                  color: Colors.red)
            ],
          ),
        ),
      ),
    );
  }

  // Widget for displaying information rows
  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.cyan, size: 22),
          SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
