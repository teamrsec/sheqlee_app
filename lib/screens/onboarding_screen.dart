import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheqlee_app/screens/login_screen.dart';
import 'package:sheqlee_app/screens/terms_and_conditions_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoSwipeTimer;

  final List<Map<String, String>> _onboardingData = [
    {
      'header': 'Header text',
      'body': 'Body text will be written here, maybe in two lines.',
    },
    {
      'header': 'Header text',
      'body': 'Body text will be written here, maybe in two lines.',
    },
    {
      'header': 'Header text',
      'body': 'Body text will be written here, maybe in two lines.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSwipe();
  }

  @override
  void dispose() {
    _autoSwipeTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSwipe() {
    _autoSwipeTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      int nextPage = (_currentPage + 1) % _onboardingData.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    // PageView for Onboarding Screens
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: _onboardingData.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                height: 183.h,
                                width: 183.w,
                                padding: EdgeInsets.all(25.0),
                                child: Image.asset(
                                  'assets/images/image.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              _onboardingData[index]['header']!,
                              style: TextStyle(
                                fontSize: 50.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard',
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              _onboardingData[index]['body']!,
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w300
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    // Dots positioned near the bottom of the PageView
                    Positioned(
                      bottom: 120.h,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          _onboardingData.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: _buildDot(isActive: index == _currentPage),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Log In Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 137, 103, 179),
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    textStyle: TextStyle(fontSize: 20.sp),
                  ),
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),

              // Sign Up Text Button
              Padding(
                padding: EdgeInsets.all(10.h),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsAndConditionsScreen(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      'New to Sheqlee? Sign up!',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 112, 112, 112),
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build individual dots
  Widget _buildDot({required bool isActive}) {
    return Container(
      width: isActive ? 20.w : 7.w,
      height: 7.h,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(4.h),
        color: isActive
            ? const Color.fromARGB(255, 137, 103, 179)
            : const Color.fromARGB(137, 137, 103, 179),
      ),
    );
  }
}
