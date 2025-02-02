import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  required String title,
  required Widget content, 
  required String cancelButtonText,
  required String confirmButtonText,
  required Function() onConfirm, 
  Color? confirmButtonColor,
  Color? cancelButtonColor,
  bool isConfirmButtonEnabled = true, 
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ),
        content: content, 
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.w, vertical: 16.h),
                  side: BorderSide(
                    color: cancelButtonColor ?? const Color.fromARGB(255, 137, 103, 179),
                    width: 2.w,
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                ),
                child: Text(
                  cancelButtonText,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: cancelButtonColor ?? const Color.fromARGB(255, 137, 103, 179),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: isConfirmButtonEnabled
                    ? () {
                        onConfirm();
                        Navigator.of(context).pop();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 40.w, vertical: 16.h),
                  backgroundColor: isConfirmButtonEnabled
                      ? confirmButtonColor ?? const Color.fromARGB(255, 137, 103, 179)
                      : Colors.black,
                  disabledBackgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                ),
                child: Text(
                  confirmButtonText,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}