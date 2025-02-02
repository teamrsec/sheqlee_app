import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomObscureText extends StatelessWidget {
  final TextEditingController controller;
  final bool isPasswordVisible;
  final double circleSize;
  final Color circleColor;
  final double spacing;

  CustomObscureText({
    required this.controller,
    required this.isPasswordVisible,
    this.circleSize = 10.0,
    this.circleColor = Colors.black,
    this.spacing = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Positioned.fill(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: List.generate(controller.text.length, (index) {
              // If the password is visible, show the characters, else show circles
              if (isPasswordVisible) {
                return Text(
                  controller.text[index], // Show actual character
                  style: TextStyle(
                    // fontSize: circleSize, // Adjust size to match circles
                    color: Colors.black,
                    fontSize: 18.sp,
                  ),
                );
              } else {
                return Container(
                  width: circleSize,
                  height: circleSize,
                  margin: EdgeInsets.only(right: spacing),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: circleColor,
                  ),
                );
              }
            }),
          ),
        ),
      ),
      ],
    );
  }
}