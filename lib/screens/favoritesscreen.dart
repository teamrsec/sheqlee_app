import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 75.w,
                height: 75.h,
                child: Image.asset('assets/images/sad@3x.png')),
            SizedBox(height: 20.h),
            Text(
              'No favorites yet',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'pretendard'),
            ),
          ],
        ),
      ),
    );
  }
}
