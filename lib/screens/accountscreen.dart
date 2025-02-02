import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheqlee_app/screens/deleteaccount.dart';
import 'package:sheqlee_app/widgets/custom_text_form_field.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final FocusNode _fullNameFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  bool isFullNameFilled = false;
  bool isEmailFilled = false;
  bool isPasswordFilled = false;
  bool isConfirmPasswordFilled = false;
  bool isUpdateButtonEnabled = false;
  
  

  @override
  void dispose() {
    // Dispose controllers and focus nodes to prevent memory leaks
    _fullNameController.dispose();
    _fullNameFocusNode.dispose();
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordController.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _handleFieldChanged(bool isFilled, String field) {
    setState(() {
      if (field == "fullName") {
        isFullNameFilled = isFilled;
      } else if (field == "email") {
        isEmailFilled = isFilled;
      } else if (field == "password") {
        isPasswordFilled = isFilled;
      } else if (field == "confirmPassword") {
        isConfirmPasswordFilled = isFilled;
      }

      // Enable button only if all fields are filled
      isUpdateButtonEnabled = isFullNameFilled &&
          isEmailFilled &&
          isPasswordFilled &&
          isConfirmPasswordFilled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Stack(
                children: [
                  CustomTextFormField(
                    controller: _fullNameController,
                    focusNode: _fullNameFocusNode,
                    labelText: 'Full Name',
                    hintText: 'Muruts Yifter',
                    isMandatory: true,
                    maxLines: 1,
                    onChanged: (value) =>
                        _handleFieldChanged(value.isNotEmpty, "fullName"),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Stack(
                children: [
                  CustomTextFormField(
                    focusNode: _emailFocusNode,
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'muruts.yifter@gmail.com',
                    isMandatory: true,
                    maxLines: 1,
                    onChanged: (value) =>
                        _handleFieldChanged(value.isNotEmpty, "email"),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Stack(
                children: [
                  CustomTextFormField(
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'New password',
                    isMandatory: false,
                    maxLines: 1,
                    isPasswordField: true,
                    onChanged: (value) =>
                        _handleFieldChanged(value.isNotEmpty, "password"),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Stack(
                children: [
                  CustomTextFormField(
                    focusNode: _confirmPasswordFocusNode,
                    controller: _confirmPasswordController,
                    labelText: 'Confirm Password',
                    hintText: 'Repeat for confirmation',
                    isMandatory: false,
                    maxLines: 1,
                    isPasswordField: true,
                    onChanged: (value) =>
                        _handleFieldChanged(value.isNotEmpty, "confirmPassword"),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                'Leave empty if you do not want to change your password.',
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
              SizedBox(height: 30.h),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: isUpdateButtonEnabled
                      ? () {
                          // Add update logic
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isUpdateButtonEnabled
                        ? const Color.fromARGB(255, 137, 103, 179)
                        : Colors.black,
                    disabledBackgroundColor: Colors.black,
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                  ),
                  child: SizedBox(
                    child: Text(
                      'Update settings',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Add log out logic
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              title: Center(
                                child: Text(
                                  'Log out',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'pretendard'),
                                ),
                              ),
                              titlePadding: EdgeInsets.only(top: 20.h),
                              content: const Text(
                                'Are you sure you want to log \n out of your account?',
                                textAlign: TextAlign.center,
                              ),
                              contentTextStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              actionsPadding: EdgeInsets.only(bottom: 10.h),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                            color: Color.fromARGB(255, 137, 103,
                                                179), // Border color
                                            width: 1.5, // Border width
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                40.r), // Border radius
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24.w),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 137, 103, 179),
                                              fontSize: 18.sp,
                                              fontFamily: 'pretendard',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 137, 103, 179),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 48.w),
                                        ),
                                        onPressed: () {
                                          // Add log out logic here
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text(
                                          'Log out',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontFamily: 'pretendard',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'Log out',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DeleteAccount()),
                        );
                      },
                      child: Text(
                        'Delete account',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
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
