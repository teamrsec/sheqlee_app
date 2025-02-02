import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheqlee_app/constants/custom_back_button.dart';
import 'package:sheqlee_app/screens/welcome_dashboard.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isCompanySelected = true; // Toggle for Company and Professional
  bool _isPasswordVisible = false; // Toggle for password visibility
  bool _isPasswordMismatch = false; // Tracks if passwords do not match

  // Controllers for text fields
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Check if the button should be enabled
  bool get _isButtonEnabled {
    bool isEmailValid(String email) {
      String pattern = r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+$';
      RegExp regex = RegExp(pattern);
      return regex.hasMatch(email);
    }

    // Ensure all required fields are filled and email is valid
    if (isCompanySelected) {
      return _companyNameController.text.isNotEmpty &&
          _domainController.text.isNotEmpty &&
          _nameController.text.isNotEmpty &&
          isEmailValid(_emailController.text) &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
    } else {
      return _nameController.text.isNotEmpty &&
          isEmailValid(_emailController.text) &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
    }
  }

  // Update the state whenever text changes
  void _onTextChanged() {
    setState(() {
      _isPasswordMismatch = false; // Reset the mismatch flag on text change
    });
  }

  @override
  void initState() {
    super.initState();
    // Add listeners to update the state on text changes
    _companyNameController.addListener(_onTextChanged);
    _domainController.addListener(_onTextChanged);
    _nameController.addListener(_onTextChanged);
    _emailController.addListener(_onTextChanged);
    _passwordController.addListener(_onTextChanged);
    _confirmPasswordController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    // Remove listeners to avoid memory leaks
    _companyNameController.removeListener(_onTextChanged);
    _domainController.removeListener(_onTextChanged);
    _nameController.removeListener(_onTextChanged);
    _emailController.removeListener(_onTextChanged);
    _passwordController.removeListener(_onTextChanged);
    _confirmPasswordController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _register() {
    FocusScope.of(context).unfocus();
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _isPasswordMismatch = true; // Update state to reflect password mismatch
      });
      return;
    }

    // Simulate registration and navigate to WelcomeDashboard
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeDashboard(userName: _nameController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.h,
          leading: const CustomBackButton(),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign up',
                          style: TextStyle(
                              fontSize: 26.sp, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 30.h),
              
                        // Toggle between Company and Professional
                        Row(
                          children: [
                            _buildToggleOption('Company', isCompanySelected, () {
                              setState(() {
                                isCompanySelected = true;
                              });
                            }),
                            const Spacer(),
                            _buildToggleOption('Professional', !isCompanySelected,
                                () {
                              setState(() {
                                isCompanySelected = false;
                              });
                            }),
                          ],
                        ),
                        SizedBox(height: 20.h),
              
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Dynamic Text Fields
                              if (isCompanySelected) ...[
                                _buildTextField(
                                    "Company name", _companyNameController),
                                _buildTextField("Domain", _domainController),
                                SizedBox(height: 30.h),
                                Text(
                                  "Company representative",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                              ],
                              _buildTextField("Name", _nameController),
                              _buildTextField("E-mail", _emailController),
                              _buildPasswordField("Password",
                                  _passwordController, _isPasswordMismatch),
                              _buildPasswordField(
                                  "Confirm password",
                                  _confirmPasswordController,
                                  _isPasswordMismatch),
                              Row(
                                children: [
                                  if (_isPasswordMismatch)
                                    Expanded(
                                      child: Text(
                                        'Password doesn’t match',
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
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
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
                                              ? const Color.fromARGB(
                                                  255, 137, 103, 179)
                                              : const Color.fromARGB(
                                                  255, 192, 192, 192),
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          _isPasswordVisible
                                              ? 'Show'
                                              : 'Hidden',
                                          style: TextStyle(
                                            color: _isPasswordVisible
                                                ? const Color.fromARGB(
                                                    255, 0, 0, 0)
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
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                        const Spacer(),
              
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isButtonEnabled && !_isPasswordMismatch
                                ? _register
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isButtonEnabled
                                  ? const Color.fromARGB(255, 137, 103, 179)
                                  : Colors.black,
                              disabledBackgroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                            ),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
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
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildToggleOption(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isSelected
                  ? null // No border when clicked
                  : Border.all(
                      color: Colors.black,
                      width: 1.3, // Border width matches icon size
                    ),
              color: isSelected
                  ? const Color.fromARGB(255, 137, 103, 179)
                  : Colors.transparent, // Fill color
            ),
            child: Center(
              child: Icon(
                Icons.check,
                size: 19.sp, // Adjusted size of the icon
                color: isSelected
                    ? Colors.white
                    : Colors.black, // Icon color changes based on value
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hinttext, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          hintText: hinttext,
          hintStyle: TextStyle(
              color: const Color.fromARGB(255, 208, 208, 208),
              fontSize: 18,
              fontFamily: 'pretendard'),
          border: const UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Color.fromARGB(255, 208, 208, 208),
          )),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.w,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
      String hintText, TextEditingController controller, bool isError) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: TextField(
        controller: controller,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 208, 208, 208),
              fontSize: 18,
              fontFamily: 'pretendard'),
          border: const UnderlineInputBorder(), // Default underline border
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: _isPasswordMismatch
                  ? const Color.fromARGB(255, 234, 67, 53)
                  : const Color.fromARGB(255, 208, 208, 208),
              width: 1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.w,
            ),
          ),
        ),
      ),
    );
  }
}
