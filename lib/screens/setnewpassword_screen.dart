import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheqlee_app/constants/custom_back_button.dart';
import 'package:sheqlee_app/screens/login_screen.dart';

class SetNewPasswordScreen extends StatefulWidget {
  final String email;
  const SetNewPasswordScreen({required this.email,super.key});

  @override
  _SetNewPasswordScreenState createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isFormValid = false;
  bool _isPasswordVisible = false;
  bool _passwordMismatchError = false;

  @override
  void initState() {
    super.initState();
    _codeController.addListener(_updateButtonState);
    _newPasswordController.addListener(_updateButtonState);
    _confirmPasswordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isFormValid = _validateInputs();
      if (_newPasswordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _newPasswordController.text == _confirmPasswordController.text) {
        _passwordMismatchError = false;
      }
    });
  }

  bool _validateInputs() {
    return _codeController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _newPasswordController.text.length >= 6;
  }

  void _changePassword() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _passwordMismatchError =
            _newPasswordController.text != _confirmPasswordController.text;
      });

      if (!_passwordMismatchError) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    }
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
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Set a new password',
                style: TextStyle(
                  fontSize: 26.sp,
                  fontFamily: 'pretendard',
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'A code has been sent to ${widget.email}.',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'pretendard',
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 116, 116, 116),
                ),
              ),
              SizedBox(height: 30.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _codeController,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Code',
                        hintStyle: TextStyle(
                          fontFamily: 'pretendard',
                          fontSize: 18.sp,
                          color: const Color.fromARGB(255, 208, 208, 208),
                        ),
                        border: const UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 208, 208, 208),
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                            width: 1,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the verification code';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40.h),
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'New Password',
                        hintStyle: TextStyle(
                          fontFamily: 'pretendard',
                          fontSize: 18.sp,
                          color: const Color.fromARGB(255, 208, 208, 208),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: _passwordMismatchError
                                ? const Color.fromARGB(255, 234, 67, 53)
                                : const Color.fromARGB(255, 208, 208, 208),
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                            width: 1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Confirm New Password',
                        hintStyle: TextStyle(
                          fontFamily: 'pretendard',
                          fontSize: 18.sp,
                          color: const Color.fromARGB(255, 208, 208, 208),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: _passwordMismatchError
                                ? const Color.fromARGB(255, 234, 67, 53)
                                : const Color.fromARGB(255, 208, 208, 208),
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        if (_passwordMismatchError)
                          Expanded(
                            child: Text(
                              'Password doesn’t match',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 234, 67, 53),
                                fontSize: 14.sp,
                                fontFamily: 'pretendard',
                                fontWeight: FontWeight.bold
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
                            children: [
                              Image.asset(
                                _isPasswordVisible
                                    ? 'assets/images/seen@3x.png'
                                    : 'assets/images/hide@3x.png',
                                width: 24.w,
                                height: 24.h,
                                color: _isPasswordVisible
                                    ? const Color.fromARGB(255, 137, 103, 179)
                                    : const Color.fromARGB(255, 192, 192, 192),
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
                  ],
                ),
              ),
              const Spacer(),
              // Change Password Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isFormValid && !_passwordMismatchError
                      ? _changePassword
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid && !_passwordMismatchError
                        ? const Color.fromARGB(255, 137, 103, 179)
                        : Colors.black,
                    disabledBackgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                  ),
                  child: Text(
                    'Change Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
