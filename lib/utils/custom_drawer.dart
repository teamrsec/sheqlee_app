import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  final String userName;
  final String userTitle;

  const CustomDrawer({
    super.key,
    required this.userName,
    required this.userTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        children: <Widget>[
          // Custom Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
            child: Column(
              children: [
                // Header with Welcome Text and Edit Profile
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Circle Avatar
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
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
                            userName,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h), // Spacing between Texts
                          Text(
                            userTitle,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // Divider directly below the Row
                Divider(thickness: 1.h),
              ],
            ),
          ),

          // Drawer Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  imagePath: 'assets/images/drawer/companies@3x.png',
                  text: 'Companies',
                  onTap: () {},
                  height: 50.h, // Adjustable height
                ),
                _buildDrawerItem(
                  imagePath: 'assets/images/drawer/categories@3x.png',
                  text: 'Categories',
                  onTap: () {},
                  height: 50.h, // Adjustable height
                ),
                _buildDrawerItem(
                  imagePath: 'assets/images/drawer/tag@3x.png',
                  text: 'Tags',
                  onTap: () {},
                  height: 50.h, // Adjustable height
                ),
                _buildDrawerItem(
                  imagePath: 'assets/images/drawer/info@3x.png',
                  text: 'About',
                  onTap: () {},
                  height: 50.h, // Adjustable height
                ),
                _buildDrawerItem(
                  imagePath: 'assets/images/drawer/pages@3x.png',
                  text: 'Blog',
                  onTap: () {},
                  height: 50.h, // Adjustable height
                ),
                _buildDrawerItem(
                  imagePath: 'assets/images/drawer/tag - alt2@3x.png',
                  text: 'Pricing',
                  onTap: () {},
                  height: 50.h, // Adjustable height
                ),
                _buildDrawerItem(
                  imagePath: 'assets/images/drawer/rocket@3x.png',
                  text: 'Getting Started',
                  onTap: () {},
                  height: 50.h, // Adjustable height
                ),
                _buildDrawerItem(
                  imagePath: 'assets/images/drawer/chat@3x.png',
                  text: 'Contact',
                  onTap: () {},
                  height: 50.h, // Adjustable height
                ),
                _buildDrawerItem(
                  imagePath: 'assets/images/drawer/question-alt2@3x.png',
                  text: 'FAQ',
                  onTap: () {},
                  height: 50.h, // Adjustable height
                ),
                _buildDrawerItem(
                  imagePath: 'assets/images/drawer/handshake@3x.png',
                  text: 'Terms of Service',
                  onTap: () {},
                  height: 50.h, // Adjustable height
                ),
                _buildDrawerItem(
                  imagePath: 'assets/images/drawer/insurance@3x.png',
                  text: 'Privacy Policy',
                  onTap: () {},
                  height: 50.h, // Adjustable height
                  showUnderline: false,
                ),

                // Full-width Divider
                Divider(
                  thickness: 1.h,
                  color: const Color.fromARGB(255, 229, 229, 229),
                ),
                SizedBox(height: 30.h),
                // Social Media Icons
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialIcon('assets/images/social/facebook.png'),
                          SizedBox(width: 5.w),
                          _buildSocialIcon('assets/images/social/twitter.png'),
                          SizedBox(width: 5.w),
                          _buildSocialIcon(
                              'assets/images/social/instagram.png'),
                          SizedBox(width: 5.w),
                          _buildSocialIcon('assets/images/social/tik-tok.png'),
                          SizedBox(width: 5.w),
                          _buildSocialIcon('assets/images/social/telegram.png'),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        'v0.12.383',
                        style: TextStyle(fontSize: 12.sp),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Drawer Item with Container and adjustable height
  Widget _buildDrawerItem({
    required String imagePath,
    required String text,
    required VoidCallback onTap,
    bool showUnderline = true,
    required double height, // Default height
  }) {
    height = 30.h; // Initialize height if not provided
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: height, // Adjustable height
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 17.w,
                      height: 17.h,
                    ),
                    SizedBox(width: 30.w),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14.sp,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        if (showUnderline)
          Padding(
            padding: const EdgeInsets.only(left: 60.0),
            child: Divider(
              thickness: 1.h,
              color: const Color.fromARGB(255, 229, 229, 229),
            ),
          ),
      ],
    );
  }

  // Social Media Icon Button
  Widget _buildSocialIcon(String assetPath) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 0.5.w),
      ),
      child: CircleAvatar(
        radius: 20.r,
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(4.r),
          child: Image.asset(
            assetPath,
            width: 18.w,
            height: 18.h,
          ),
        ),
      ),
    );
  }
}
