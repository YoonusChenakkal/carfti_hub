import 'package:craftify_vendor/const/local_storage.dart';
import 'package:craftify_vendor/screens/products/product_Provider.dart';
import 'package:craftify_vendor/screens/profile/model/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/addProduct');
                },
                child: Text('addProduct')),
            ElevatedButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/register');
                },
                child: Text('register')),
            ElevatedButton(
                onPressed: () {
                  LocalStorage.clearUser();
                  Navigator.popAndPushNamed(context, '/login');
                },
                child: Text('LogOut')),
            ElevatedButton(
                onPressed: () {
                  Provider.of<ProfileProvider>(context, listen: false)
                      .fetchUser(context);
                },
                child: Text('fetch user')),
            ElevatedButton(
                onPressed: () {
                  Provider.of<ProductProvider>(context, listen: false)
                      .fetchProducts(context);
                },
                child: Text('fetch produsts')),
          ],
        ),
      ),
    );
  }
}
