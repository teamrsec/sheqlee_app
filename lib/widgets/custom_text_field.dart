import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String? label; 
  final String? hint; 
  final String? initialValue;
  final Function(String) onChanged; 
  final double width; 

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    required this.onChanged,
    required this.width, 
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();
  final TextStyle defaultLabelStyle = TextStyle(
    color: const Color.fromARGB(255, 160, 160, 160),
    fontSize: 18.sp,
  );

  @override
  void initState() {
    super.initState();
    
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    _controller.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the label if provided
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              widget.label!,
              style: defaultLabelStyle,
            ),
          ),

        
        Container(
          width: MediaQuery.of(context).size.width * widget.width,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h), 
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 208, 208, 208),
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Row(
            children: [
              // Text Field
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: widget.hint, 
                    hintStyle: defaultLabelStyle,
                    border: InputBorder.none, 
                    isDense: true, 
                    contentPadding: EdgeInsets.zero, 
                  ),
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                  onChanged: widget.onChanged, 
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}