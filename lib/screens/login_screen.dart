import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheqlee_app/constants/custom_back_button.dart';
import 'package:sheqlee_app/screens/resetpassword_screen.dart';
import 'package:sheqlee_app/widgets/custom_obscure_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isPasswordVisible = false;

  bool _isValidEmail = false;
  bool _isValidPassword = false;
  bool _isEmailInvalid = false;
  bool _isPasswordInvalid = false;
  bool _isLoggingIn = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool _validateEmail(String email) {
    return email.isNotEmpty;
  }

  bool _validatePassword(String password) {
    return password.isNotEmpty;
  }

  Future<void> _login() async {
    setState(() {
      _isLoggingIn = true;
    });

    await Future.delayed(const Duration(seconds: 0));

    if (_emailController.text == "user@example.com" &&
        _passwordController.text == "password123") {
      setState(() {
        _isLoggingIn = false;
      });
      // Navigate to the next screen
    } else {
      setState(() {
        _isLoggingIn = false;
        _isEmailInvalid = true;
        _isPasswordInvalid = true;
      });
    }
  }

  bool _validateCredentials() {
    return _isValidEmail && _isValidPassword;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: const CustomBackButton(),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Hide keyboard on tap
          },
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final keyboardVisible =
                    MediaQuery.of(context).viewInsets.bottom > 0;
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Text(
                            'Log in',
                            style: TextStyle(
                              fontSize: 26.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 50.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: TextField(
                            autofocus: true,
                            focusNode: _focusNode,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'E-mail',
                              hintStyle: TextStyle(
                                color: const Color.fromARGB(255, 208, 208, 208),
                                fontSize: 18.sp,
                                fontFamily: 'pretendard',
                              ),
                              border: const UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: _isEmailInvalid
                                      ? const Color.fromARGB(255, 234, 67, 53)
                                      : const Color.fromARGB(
                                          255, 208, 208, 208),
                                  width: 1,
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              suffixIconConstraints: BoxConstraints(
                                minHeight: 20.h,
                                minWidth: 20.w,
                              ),
                              suffixIcon: _emailController.text.isNotEmpty &&
                                      _focusNode.hasFocus
                                  ? GestureDetector(
                                      onTap: () {
                                        _emailController.clear();
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 12.h),
                                        child: Image.asset(
                                          'assets/images/cancel.png',
                                          width: 15,
                                          height: 15,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _isValidEmail = _validateEmail(value);
                                _isEmailInvalid = !_isValidEmail;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: TextField(
                                controller: _passwordController,
                                obscureText:
                                    !_isPasswordVisible, // Toggles password visibility
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 208, 208, 208),
                                    fontSize: 18.sp,
                                    fontFamily: 'pretendard',
                                  ),
                                  border: const UnderlineInputBorder(),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: _isPasswordInvalid
                                          ? const Color.fromARGB(
                                              255, 234, 67, 53)
                                          : const Color.fromARGB(
                                              255, 208, 208, 208),
                                    ),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  setState(() {
                                    _isValidPassword = _validatePassword(value);
                                    _isPasswordInvalid = !_isValidPassword;
                                  });
                                },
                              ),
                            ),
                            // Use CustomObscureText to show or hide dots based on password visibility
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: CustomObscureText(
                                    controller: _passwordController,
                                    isPasswordVisible: _isPasswordVisible,
                                    circleSize: 10.0,
                                    circleColor: Colors.black,
                                    spacing: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            children: [
                              if (_isEmailInvalid && _isPasswordInvalid)
                                Expanded(
                                  child: Text(
                                    'Incorrect credentials',
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 234, 67, 53),
                                      fontSize: 14.sp,
                                      fontFamily: 'pretendard',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              else
                                const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      _isPasswordVisible
                                          ? 'assets/images/seen@3x.png'
                                          : 'assets/images/hide@3x.png',
                                      width: 24.w,
                                      height: 24.h,
                                      color: _isPasswordVisible
                                          ? const Color.fromARGB(
                                              255, 137, 103, 179)
                                          : const Color.fromARGB(
                                              255, 192, 192, 192),
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      _isPasswordVisible ? 'Show' : 'Hidden',
                                      style: TextStyle(
                                        color: _isPasswordVisible
                                            ? const Color.fromARGB(255, 0, 0, 0)
                                            : const Color.fromARGB(
                                                255, 192, 192, 192),
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'pretendard',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ResetPasswordScreen()),
                                );
                              },
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 137, 103, 179),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoggingIn
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        _isEmailInvalid = !_isValidEmail;
                                        _isPasswordInvalid = !_isValidPassword;
                                      });
                
                                      if (_isValidEmail && _isValidPassword) {
                                        _login();
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _validateCredentials()
                                    ? const Color.fromARGB(255, 137, 103, 179)
                                    : Colors.black,
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                              ),
                              child: _isLoggingIn
                                  ? const CircularProgressIndicator(
                                      backgroundColor:
                                          Color.fromARGB(137, 137, 103, 179),
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Log in',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: keyboardVisible ? 10.h : 30.h),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
