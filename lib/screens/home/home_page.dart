import 'package:craftify_vendor/common/button.dart';
import 'package:craftify_vendor/common/custom_app_bar.dart';
import 'package:craftify_vendor/screens/home/order_card.dart';
import 'package:craftify_vendor/screens/profile/provider/profile_provider.dart';
import 'package:craftify_vendor/screens/profile/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final user = profileProvider.user;
    final orders = _getDummyOrders(); // Replace with your order data

    return Scaffold(
      appBar: homeAppBar(user != null ? user.name : 'User'),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'New Product',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        onPressed: () => Navigator.pushNamed(context, '/addProduct'),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Verification Status Banner
              if (user != null) _buildCard(user),
              const SizedBox(height: 24),

              // Orders Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Orders",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/orders'),
                    child: const Text("View All"),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Orders List
              if (orders.isEmpty) const Center(child: Text("No orders yet")),
              if (orders.isNotEmpty)
                SizedBox(
                  height: 24.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: orders.length,
                    itemBuilder: (context, index) => OrderCard(
                      order: orders[index],
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/order-details',
                        arguments: orders[index],
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 24),

              // Quick Stats
              Row(
                children: [
                  _buildStatCard("Total Products", "45", Colors.blue),
                  const SizedBox(width: 12),
                  _buildStatCard("Pending Orders", "12", Colors.orange),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(UserModel user) {
    return Card(
      color: const Color.fromARGB(255, 248, 248, 248),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(Icons.verified_user, size: 30, color: Colors.cyan[700]),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verification",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan[900],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    user.isApproved
                        ? 'Verification Completed'
                        : "Verification Pending - Under Review",
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
              onPressed: user.isApproved ? () {} : () {},
              textWidget: Text(
                user.isApproved ? 'Done' : "Check",
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

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Order> _getDummyOrders() {
    return [
      Order(
        id: "#1234",
        customer: "John Doe",
        items: 3,
        total: 149.99,
        status: "Pending",
      ),
      Order(
        id: "#1235",
        customer: "Jane Smith",
        items: 5,
        total: 299.99,
        status: "Delivered",
      ),
    ];
  }
}

class Order {
  final String id;
  final String customer;
  final int items;
  final double total;
  final String status;

  Order({
    required this.id,
    required this.customer,
    required this.items,
    required this.total,
    required this.status,
  });
}
