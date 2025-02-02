import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomBackButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'assets/images/arrow-down-sign.png',
        width: 40.w,
        height: 20.h,
        color: Colors.black,
      ),
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
    );
  }
}
