import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String labelText;
  final String hintText;
  final bool isMandatory;
  final int maxLines;
  final Function(String) onChanged;
  final Widget? suffixIcon;
  final bool isPasswordField;
  final bool showCharacterCounter; 
  final int maxLength; 
  final TextStyle? counterStyle; 

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.labelText,
    required this.hintText,
    this.isMandatory = false,
    this.maxLines = 1,
    required this.onChanged,
    this.suffixIcon,
    this.isPasswordField = false,
    this.showCharacterCounter = false,
    this.maxLength = 256,
    this.counterStyle,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFormField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isPasswordVisible = false;

  // Default Styles
  final TextStyle defaultTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
  );

  final TextStyle defaultHintStyle = TextStyle(
    color: const Color.fromARGB(255, 160, 160, 160),
    fontSize: 18.sp,
  );

  final TextStyle defaultLabelStyle = TextStyle(
    color: const Color.fromARGB(255, 160, 160, 160),
    fontSize: 14.sp,
  );

  final TextStyle defaultCounterStyle = TextStyle(
    fontSize: 14.sp,
    color: Colors.black,
  );

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode;
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            // Label Text
            Positioned(
              top: 8.h,
              left: 16.w,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.labelText,
                      style: defaultLabelStyle,
                    ),
                    if (widget.isMandatory)
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ),
            // TextField with additional spacing
            TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              maxLines: widget.maxLines,
              obscureText: widget.isPasswordField && !_isPasswordVisible,
              style: defaultTextStyle,
              maxLength: widget.showCharacterCounter
                  ? widget.maxLength
                  : null, // Enable maxLength if counter is shown
              decoration: InputDecoration(
                hintText: _isFocused ? null : widget.hintText,
                hintStyle: defaultHintStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 208, 208, 208),
                    width: 1.0.w,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0.w,
                  ),
                ),
                contentPadding: EdgeInsets.fromLTRB(16.w, 50.h, 16.w, 10.h),
                suffixIcon: widget.isPasswordField
                    ? IconButton(
                        icon: Image.asset(
                          _isPasswordVisible
                              ? 'assets/images/seen@3x.png'
                              : 'assets/images/hide@3x.png',
                          width: 21.w,
                          height: 21.h,
                          color: _isPasswordVisible
                              ? const Color.fromARGB(255, 137, 103, 179)
                              : const Color.fromARGB(255, 192, 192, 192),
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      )
                    : widget.suffixIcon,
                counterText: widget.showCharacterCounter ? '' : null,// Hide default counter if not needed
              ),
              onChanged: widget.onChanged,
            ),
            // Custom Character Counter
            if (widget.showCharacterCounter)
              Positioned(
                right: 16.w,
                bottom: 16.h,
                child: Text(
                  '${widget.controller.text.length}/${widget.maxLength}',
                  style: widget.counterStyle ?? defaultCounterStyle,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
