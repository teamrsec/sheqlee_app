import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheqlee_app/screens/accountscreen.dart';
import 'package:sheqlee_app/screens/dashboardscreen.dart';
import 'package:sheqlee_app/screens/favoritesscreen.dart';
import 'package:sheqlee_app/screens/homescreen.dart';
import 'package:sheqlee_app/screens/editprofilescreen.dart';
import 'package:sheqlee_app/utils/custom_drawer.dart';

class WelcomeDashboard extends StatefulWidget {
  final String userName;
  

  const WelcomeDashboard({super.key, required this.userName});

  @override
  _WelcomeDashboardState createState() => _WelcomeDashboardState();
}

class _WelcomeDashboardState extends State<WelcomeDashboard> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Define all screens here
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      const DashboardScreen(),
      const FavoritesScreen(),
      const AccountScreen(), 
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      drawer: CustomDrawer(
        userName: "Muruts Yifter",
        userTitle: "Professional",
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 50.h),
        child: Column(
          children: [
            // Header with Welcome Text and Edit Profile
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Circle Avatar
                  GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Colors.black,
                      child: Image.asset(
                        'assets/images/sheqlee_logo3.png',
                        fit: BoxFit.cover,
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w), // Spacing between Avatar and Text

                  // Column for Welcome Text and Edit Profile Text
                  IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, ${widget.userName}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h), // Spacing between Texts
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfileScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Edit profile',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color.fromARGB(255, 137, 103, 179),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),

            // Divider directly below the Row
            Divider(thickness: 1.h),

            // Screen content based on _currentIndex
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: _screens,
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar for switching screens
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 229, 229, 229),
            width: 1.w,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index >= 0 && index < _screens.length) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          selectedItemColor: const Color.fromARGB(255, 137, 103, 179),
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Image.asset(
                  'assets/images/home-outline.png', // Unselected icon
                  width: 30.02.w,
                  height: 29.81.h,
                ),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Image.asset(
                  'assets/images/home-solid.png', // Selected icon
                  width: 30.02.w,
                  height: 29.81.h,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Image.asset(
                  'assets/images/activity.png', // Unselected icon
                  width: 30.01.w,
                  height: 30.h,
                ),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Image.asset(
                  'assets/images/activity-solid.png', // Selected icon
                  width: 30.01.w,
                  height: 30.h,
                ),
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Image.asset(
                  'assets/images/heart.png', // Unselected icon
                  width: 30.01.w,
                  height: 26.13.h,
                ),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Image.asset(
                  'assets/images/heart-solid.png', // Selected icon
                  width: 30.01.w,
                  height: 26.13.h,
                ),
              ),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Image.asset(
                  'assets/images/user.png', // Unselected icon
                  width: 23.32.w,
                  height: 25.95.h,
                ),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Image.asset(
                  'assets/images/user-solid.png', // Selected icon
                  width: 23.32.w,
                  height: 25.95.h,
                ),
              ),
              label: 'Account',
            ),
          ],
          selectedLabelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 137, 103, 179),
            fontFamily: 'pretendard',
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: 'pretendard',
          ),
        ),
      ),
    );
  }
}
