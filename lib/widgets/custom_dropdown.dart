import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async'; // For Timer

class CustomDropdown extends StatefulWidget {
  final String label;
  final List<String> items;
  final String? selectedValue;
  final Function(String?) onChanged;
  final double width; 
  final bool dialog;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.width,
    required this.dialog,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isDropdownOpen = false;
  String? _selectedValue;
  final LayerLink _layerLink = LayerLink(); // For positioning the dropdown menu
  OverlayEntry? _overlayEntry; // For managing the dropdown overlay
  final selectedValuestyle = TextStyle(
    color: Colors.black,
    fontSize: 18.sp,
  );
  final TextStyle defaultLabelStyle = TextStyle(
    color: const Color.fromARGB(255, 160, 160, 160),
    fontSize: 18.sp,
  );
  final ScrollController _scrollController = ScrollController();
  double _scrollIndicatorHeight = 0;
  double _scrollIndicatorOffset = 0;
  bool _isScrolling = false; // Track if the user is scrolling
  Timer?
      _scrollEndTimer; // Timer to hide the scroll indicator after scrolling stops

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
    _updateScrollIndicatorHeight();
  }

  void _updateScrollIndicatorHeight() {
    // Adjust the scroll indicator height based on the number of items
    final int itemCount = widget.items.length;
    if (itemCount <= 5) {
      _scrollIndicatorHeight = 40.h; // Larger size for fewer items
    } else if (itemCount <= 10) {
      _scrollIndicatorHeight = 30.h; // Medium size for moderate items
    } else {
      _scrollIndicatorHeight = 20.h; // Smaller size for many items
    }
  }

  void _openDropdown(BuildContext context) {
    setState(() {
      _isDropdownOpen = true;
    });

    // Create an overlay entry for the dropdown menu
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width * widget.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0, 44), // Position below the dropdown button
            child: Material(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 300.h, // Set max height for scrolling
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                  border: Border.all(color: Colors.black, width: 1.w),
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          // Dropdown Items
                          ...widget.items.map((item) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedValue = item;
                                  _isDropdownOpen = false;
                                });
                                widget.onChanged(item);
                                _overlayEntry?.remove(); // Close the dropdown
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 8.h,
                                ),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    // Scroll Indicator
                    Positioned(
                      top: _scrollIndicatorOffset,
                      right: 4.w,
                      child: Visibility(
                        visible: _isScrolling,
                        child: Container(
                          width: 5.w,
                          height: _scrollIndicatorHeight,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    // Insert the overlay into the overlay stack
    Overlay.of(context).insert(_overlayEntry!);

    // Listen to scroll changes to update the scroll indicator position
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        final double maxScrollExtent =
            _scrollController.position.maxScrollExtent;
        final double scrollOffset = _scrollController.offset;

        // Calculate the scroll indicator's position based on the scroll offset
        setState(() {
          _scrollIndicatorOffset = (scrollOffset / maxScrollExtent) *
              (300.h - _scrollIndicatorHeight);
          _isScrolling = true; // Show the scroll indicator
        });

        // Reset the timer whenever the user scrolls
        _scrollEndTimer?.cancel();
        _scrollEndTimer = Timer(const Duration(seconds: 2), () {
          setState(() {
            _isScrolling =
                false; // Hide the scroll indicator after 1 second of inactivity
          });
        });

        // Rebuild the overlay to update the scroll indicator position
        _overlayEntry?.markNeedsBuild();
      }
    });
  }

  void _closeDropdown() {
    setState(() {
      _isDropdownOpen = false;
    });
    _overlayEntry?.remove(); // Remove the overlay
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollEndTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown Button
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: () {
              if (_isDropdownOpen) {
                _closeDropdown();
              } else {
                _openDropdown(context);
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * widget.width,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                border: _isDropdownOpen
                    ? Border.all(color: Colors.black, width: 1.w)
                    : Border.all(
                        color: widget.dialog ? const Color.fromARGB(255, 208, 208, 208) : Colors.black,
                        width: 1.w),
                borderRadius: _isDropdownOpen
                    ? BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      )
                    : BorderRadius.circular(40.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedValue ?? widget.label,
                    style: _selectedValue != null
                        ? selectedValuestyle
                        : defaultLabelStyle,
                  ),
                  Transform.rotate(
                    angle:
                        _isDropdownOpen ? 3.14 : 0, // Rotate the dropdown icon
                    child: Image.asset(
                      'assets/images/arrow-down-sign-to-navigate@3x.png',
                      width: 10.02.w,
                      height: 11.5.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
