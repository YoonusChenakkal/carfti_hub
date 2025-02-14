import 'package:craftify_vendor/common/product_details_page.dart';
import 'package:craftify_vendor/screens/Login/login_page.dart';
import 'package:craftify_vendor/screens/bottom%20navigation%20bar/bottom_bar.dart';
import 'package:craftify_vendor/screens/home_page.dart';
import 'package:craftify_vendor/screens/products/add_product_page.dart';
import 'package:craftify_vendor/screens/products/product_Provider.dart';
import 'package:craftify_vendor/screens/profile/model/provider/profile_provider.dart';
import 'package:craftify_vendor/screens/profile/profile_page.dart';
import 'package:craftify_vendor/screens/Auth/auth_provider.dart';
import 'package:craftify_vendor/screens/Auth/register_page.dart';
import 'package:craftify_vendor/screens/Auth/store_setup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ChangeNotifierProvider(create: (_) => ProductProvider())
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
          home: LoginPage(),
          initialRoute: '/bottomBar',
          routes: {
            '/login': (context) => LoginPage(),
            '/register': (context) => RegisterPage(),
            '/storeSetup': (context) => StoreSetupPage(),
            '/bottomBar': (context) => BottomBar(),
            '/home': (context) => HomePage(),
            '/profile': (context) => ProfilePage(),
            '/addProduct': (context) => AddProductPage(),
            '/productDetails' : (context)=> ProductDetailPage()
          });
    });
  }
}
