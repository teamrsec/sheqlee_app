import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheqlee_app/constants/custom_back_button.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isButtonEnabled = _controller.text.trim().isNotEmpty;
      });
    });
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(
          'Delete Account',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Your account will be available for recovery for a period of one month after deletion. After that, it will be permanently deleted and cannot be recovered.',
              style: TextStyle(fontSize: 14.sp, height: 1.5),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 40.h),
            Stack(
              children: [
                TextField(
                  focusNode: _focusNode,
                  controller: _controller,
                  maxLines: 6,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black, // Color of the typed text
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 208, 208, 208),
                          width: 1.0.w),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 208, 208, 208),
                          width: 1.0.w),
                    ),
                    labelText: '',
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.fromLTRB(16.w, 75.h, 16.w, 16.h),
                  ),
                ),
                Positioned(
                  left: 16.w,
                  top: 20.h,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(_focusNode);
                    },
                    child: Text(
                      'Deletion reason',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16.w,
                  top: 55.h,
                  child: _focusNode.hasFocus || _controller.text.isNotEmpty
                      ? SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(_focusNode);
                          },
                          child: Text(
                            'Tell us why you’re deleting your account',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 160, 160, 160),
                            ),
                          ),
                        ),
                ),
                Positioned(
                  right: 16.w,
                  bottom: 16.h,
                  child: Text(
                    '${_controller.text.length}/256',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 7.h),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 245, 245, 245),
                border: Border(
                  top: BorderSide(
                      color: const Color.fromARGB(255, 229, 229, 229),
                      width: 1.w),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled
                      ? () {
                          // Add your onPressed logic here
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                title: Center(
                                  child: Text(
                                    'Delete Account',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.sp),
                                  ),
                                ),
                                titlePadding:
                                    EdgeInsets.only(top: 30.h, bottom: 5.h),
                                content: const Text(
                                  'Are you sure you want to \n delete your account?',
                                  textAlign: TextAlign.center,
                                ),
                                contentTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                                actionsPadding: EdgeInsets.only(bottom: 10.h),
                                actions: <Widget>[
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
                                              color: Color.fromARGB(255, 137,
                                                  103, 179), // Border color
                                              width: 1.5, // Border width
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 234, 67, 53),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 48.w),
                                          ),
                                          onPressed: () {
                                            // Add log out logic here
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: Text(
                                            'Delete',
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
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isButtonEnabled ? Colors.red : Colors.black,
                    disabledBackgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    'Delete account',
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
