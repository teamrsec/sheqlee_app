import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:sheqlee_app/constants/custom_back_button.dart';
import 'package:sheqlee_app/screens/setnewpassword_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _emailError;
  bool _isEmailValid = false; // Track email validity

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateButtonState);
    _emailController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isEmailValid = _isValidEmail(_emailController.text);
    });
  }

  Future<void> _resetPassword() async {
    // Simulate backend logic, e.g., calling an API
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    setState(() {
      _emailError = null; // Clear any previous error message
    });

    if (_isEmailValid) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetNewPasswordScreen(email: _emailController.text),
        ),
      );

      // Navigator.pop(
      //     context); // Go back to the Login Screen after successful reset
    } else {
      setState(() {
        _emailError = 'Please enter a valid email address.';
      });
    }
  }

  bool _isValidEmail(String email) {
    // Improved email validation using a regex pattern
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when the user taps outside the text fields
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reset Password',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'pretendard'),
              ),
              SizedBox(height: 60.h),
              // Reset Password Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'E-mail',
                        hintStyle: TextStyle(
                            fontSize: 18.sp,
                            color: const Color.fromARGB(255, 208, 208, 208)),
                        border: const UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 208, 208, 208),
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                            width: 1,
                          ),
                        ),
                        errorText: _emailError,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        // Basic email validation
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        } else if (!_isValidEmail(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(), // Pushes the button to the bottom
              // Send Code Button
              SizedBox(
                width: double.infinity, // Makes the button expand horizontally
                child: ElevatedButton(
                  onPressed: _isEmailValid
                      ? () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _resetPassword();
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isEmailValid
                        ? const Color.fromARGB(255, 137, 103, 179)
                        : Colors.black, // Button color
                    disabledBackgroundColor:
                        Colors.black, // Force black when disabled
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                  ),
                  child: Text(
                    'Send Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,fontFamily: 'pretendard',
                    ),
                  ),
                ),
              ),
          
              SizedBox(height: 20.h), // Add some space below the button
            ],
          ),
        ),
      ),
    );
  }
}
