import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheqlee_app/constants/custom_back_button.dart';

class JobDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> jobDetails;

  const JobDetailsScreen({super.key, required this.jobDetails});

  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool isApplied = false;

  void toggleApplication() {
    setState(() {
      isApplied = !isApplied;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isApplied ? 'Applied successfully' : 'Application Canceled',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        margin: const EdgeInsets.only(
          bottom: 20.0,
          left: 100.0,
          right: 100.0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final job = widget.jobDetails;

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text(
          'Job Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Scrollable body content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildCircularButton(job['type'] ?? ''),
                      SizedBox(width: 10.w),
                      _buildCircularButton(job['level'] ?? ''),
                      SizedBox(width: 10.w),
                      _buildCircularButton(job['pay'] ?? ''),
                      SizedBox(width: 20.w),
                      const Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    job['title'] ?? '',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Posted: ${job['timeAgo'] ?? ''}",
                    style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      job['companyName'] ?? '',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 137, 103, 179),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    job['description'] ?? '',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: 20.h),
                    RichText(
                    text: TextSpan(
                      text: 'Qualifications \n',
                      style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      ),
                      children: [
                      TextSpan(
                        text: job['qualifications']?.join(', ') ?? 'N/A',
                        style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        height: 2.h,
                        ),
                      ),
                      ],
                    ),
                    ),
                  SizedBox(height: 10.h),
                    RichText(
                    text: TextSpan(
                      text: 'Experience \n',
                      style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      ),
                      children: [
                      TextSpan(
                        text: job['experience']?.join(', ') ?? 'N/A',
                        style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        height: 2.h,
                        ),
                      ),
                      ],
                    ),
                    ),
                  SizedBox(height: 10.h),
                    RichText(
                    text: TextSpan(
                      text: 'Skills & Knowledges \n',
                      style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,fontWeight: FontWeight.w500,
                      ),
                      children: [
                      TextSpan(
                        text: job['skills']?.join(',\n ') ?? 'N/A',
                        style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        height: 2.h,
                        ),
                      ),
                      ],
                    ),
                    ),
                  SizedBox(height: 10.h),
                    RichText(
                    text: TextSpan(
                      text: 'Description \n',
                      style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      ),
                      children: [
                      TextSpan(
                        text: job['LongDescription'] ?? 'N/A',
                        style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        height: 2.h,
                        ),
                      ),
                      ],
                    ),
                    ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 24.w),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 245, 245),
              border: Border(
                top: BorderSide(
                    color: const Color.fromARGB(255, 229, 229, 229),
                    width: 1.w),
              ),
            ),
            child: Row(
              children: [
                // Apply Now button
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.6, // 60% of the screen width
                  child: ElevatedButton(
                    onPressed: toggleApplication,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isApplied
                          ? const Color.fromARGB(255, 234, 67, 53)
                          : const Color.fromARGB(255, 137, 103, 179),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.r),
                      ),
                    ),
                    child: Text(
                      isApplied ? 'Cancel application' : 'Apply now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // Share button
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.25, // 25% of the screen width
                  child: OutlinedButton(
                    onPressed: () {
                      // Logic for share button
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: const Color.fromARGB(255, 137, 103, 179),
                        width: 2.0,
                      ),
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.r),
                      ),
                    ),
                    child: Text(
                      'Share',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 137, 103, 179),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to build circular buttons 
  Widget _buildCircularButton(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1.w),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
