import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheqlee_app/constants/custom_back_button.dart';
import 'package:sheqlee_app/screens/signup_screen.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

// Widget for Circular Checkbox Row
Widget _buildCircularCheckboxRow({
  required Widget title,
  required bool value,
  required ValueChanged<bool?> onChanged,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h), // Reduced spacing
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Circular Checkbox
        GestureDetector(
          onTap: () {
            onChanged(!value);
          },
          child: Container(
            width: 26.w,
            height: 26.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: value
                  ? null // No border when clicked
                  : Border.all(
                      color: Colors.black,
                      width: 1.3, // Border width matches icon size
                    ),
              color: value
                  ? const Color.fromARGB(255, 137, 103, 179)
                  : Colors.transparent, // Fill color
            ),
            child: Center(
              child: Icon(
                Icons.check,
                size: 21.sp, // Adjusted size of the icon
                color: value
                    ? Colors.white
                    : Colors.black, // Icon color changes based on value
              ),
            ),
          ),
        ),
        SizedBox(width: 15.w), // Spacing between checkbox and text
        Expanded(
          child: title,
        ),
      ],
    ),
  );
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  // State to manage checkbox selection
  bool _agreeAll = false;
  bool _agreeToService = false;
  bool _agreeToPrivacy = false;
  bool _agreeToMarketing = false;

  // Function to toggle all checkboxes
  void _toggleAllCheckboxes(bool value) {
    setState(() {
      _agreeAll = value;
      _agreeToService = value;
      _agreeToPrivacy = value;
      _agreeToMarketing = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),

            // Title: Agree to Terms & Conditions
            Text(
              'Agree to terms & conditions',
              style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'pretendard'),
            ),

            const Spacer(), // Pushes the checkboxes to the bottom

            // "Agree to All Terms" Checkbox
            _buildCircularCheckboxRow(
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    _agreeAll = !_agreeAll;
                    _toggleAllCheckboxes(_agreeAll);
                  });
                },
                child: Text(
                  'I agree to all terms',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'pretendard'),
                ),
              ),
              value: _agreeAll,
              onChanged: (value) {
                _toggleAllCheckboxes(value ?? false);
              },
              // Change color based on state
            ),
            Divider(height: 15.h, color: Colors.grey),

            // Individual Checkboxes with Expand buttons
            _buildExpandableCheckboxRow(
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    _agreeToService = !_agreeToService;
                    _updateAgreeAllState();
                  });
                },
                child: Text(
                  'I agree to Terms of Service',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'pretendard',
                  ),
                ),
              ),
              value: _agreeToService,
              onChanged: (value) {
                setState(() {
                  _agreeToService = value ?? false;
                  _updateAgreeAllState();
                });
              },
              isMandatory: true, // Mandatory checkbox
            ),

// Mandatory checkbox for Privacy Policy
            _buildExpandableCheckboxRow(
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    _agreeToPrivacy = !_agreeToPrivacy;
                    _updateAgreeAllState();
                  });
                },
                child: Text(
                  'I agree to Privacy Policy',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'pretendard',
                  ),
                ),
              ),
              value: _agreeToPrivacy,
              onChanged: (value) {
                setState(() {
                  _agreeToPrivacy = value ?? false;
                  _updateAgreeAllState();
                });
              },
              isMandatory: true, // Mandatory checkbox
            ),

// Optional checkbox for Marketing Emails
            _buildExpandableCheckboxRow(
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    _agreeToMarketing = !_agreeToMarketing;
                    _updateAgreeAllState();
                  });
                },
                child: Text(
                  'I agree to receive marketing e-mails',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'pretendard',
                  ),
                ),
              ),
              value: _agreeToMarketing,
              onChanged: (value) {
                setState(() {
                  _agreeToMarketing = value ?? false;
                  _updateAgreeAllState();
                });
              },
              isMandatory: false, // Optional checkbox
            ),

            SizedBox(height: 40.h),

            // Next Button
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        (_agreeAll || (_agreeToService && _agreeToPrivacy))
                            ? const Color.fromARGB(255, 137, 103, 179)
                            : Colors.black,
                    disabledBackgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: (_agreeAll || (_agreeToService && _agreeToPrivacy))
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        }
                      : null, // Disable button if not all terms are checked
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'pretendard'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  // Function to update "Agree All" state based on individual checkboxes
  void _updateAgreeAllState() {
    setState(() {
      _agreeAll = _agreeToService && _agreeToPrivacy && _agreeToMarketing;
    });
  }

  // Widget for Expandable Checkbox Row
  Widget _buildExpandableCheckboxRow({
    required Widget title,
    required bool value,
    required ValueChanged<bool?> onChanged,
    bool isMandatory =
        false, // New parameter to determine if checkbox is mandatory
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h), // Reduced spacing
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Circular Checkbox
              GestureDetector(
                onTap: () {
                  onChanged(!value);
                },
                child: Container(
                  width: 21.w,
                  height: 21.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: value
                        ? null // No border when clicked
                        : Border.all(
                            color: Colors.black,
                            width: 1.3, // Border width matches icon size
                          ),
                    color: value
                        ? const Color.fromARGB(255, 137, 103, 179)
                        : Colors.transparent, // Fill color
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      size: 17.sp, // Adjusted size of the icon
                      color: value
                          ? Colors.white
                          : Colors.black, // Icon color changes based on value
                    ),
                  ),
                ),
              ),
              // Space between checkbox and asterisk or additional space
              SizedBox(width: 8.w),

              // Conditionally display asterisk for mandatory checkboxes
              if (isMandatory)
                Text(
                  '* ',
                  style: TextStyle(
                    color: value ? const Color.fromARGB(255, 137, 103, 179) : Colors.red,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'pretendard',
                  ),
                )
              else
                SizedBox(width: 12.w), // Add space for non-mandatory checkboxes

              // Space between asterisk and title text
              // SizedBox(width: 8.w),

              title,

              const Spacer(),
              // Expand icon
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..scale(-1.0, 1.0), // Flip horizontally
                child: Image.asset(
                  'assets/images/arrow-down-sign-to-navigate.png',
                  width: 10.02.w,
                  height: 11.5.h,
                  color: const Color.fromARGB(255, 160, 160, 160),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
