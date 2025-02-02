import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheqlee_app/screens/onboarding_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 137, 103, 179),
      resizeToAvoidBottomInset: false, // Ensures screen stays full size
      body: SizedBox(
        width: double.infinity, // Take full width
        height: double.infinity, // Take full height
        child: Stack(
          children: [
            // Centered image
            Center(
              child: Image.asset(
                'assets/images/sheqlee_logo.png',
                width: 100.w,
                height: 100.h,
                fit: BoxFit.contain, // Prevent image distortion
              ),
            ),
            // Text at the bottom center
            Positioned(
              bottom: 50.h, // Adjust spacing from the bottom
              left: 0.h,
              right: 0.h,
              child: Center(
                child: Text(
                  'Sheqlee',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.sp,
                    fontFamily: 'Recoleta',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
