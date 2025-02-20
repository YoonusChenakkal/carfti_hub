import 'package:craftify_vendor/const/local_storage.dart';
import 'package:craftify_vendor/screens/products/product_Provider.dart';
import 'package:craftify_vendor/screens/profile/provider/profile_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward(); // Start the animation

    _initializeApp();
  }

  void _initializeApp() async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final userId = await LocalStorage.getUser();
    Future.delayed(Duration(seconds: 2), () async {
      if (userId != null) {
        await profileProvider.fetchUser(context);
        Navigator.pushReplacementNamed(context, '/bottomBar');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _animation,
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.jpg',
                height: 20.h,
                width: 20.h,
              ),
              SizedBox(
                height: 1.h,
              ),
              RichText(
                text: TextSpan(
                  text: 'Crafti  ',
                  style: GoogleFonts.cairoPlay(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Hub',
                      style: GoogleFonts.novaSquare(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.cyan,
                      ),
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
}
