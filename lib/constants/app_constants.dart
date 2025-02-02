// import 'package:flutter/material.dart';
// import 'package:sheqlee_app/data/dummy_jobs.dart';
// import 'package:sheqlee_app/screens/job_details_screen.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class AppConstants extends StatefulWidget {
//   const AppConstants({required this.job,super.key});
// final Map<String, dynamic> job;
//   @override
//   State<AppConstants> createState() => _AppConstantsState();
// }

// class _AppConstantsState extends State<AppConstants> {
//   final List<Map<String, dynamic>> jobs = dummyJobs;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      // body: ListView.builder(
      //   itemCount: jobs.length,
      //   itemBuilder: (context, index) {
      //     final job = jobs[index];
      //     return Card(
      //       margin: EdgeInsets.all(10),
      //       child: ListTile(
      //         title: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               job['timeAgo'] ?? '', // Access the 'timeAgo' key
      //               style: TextStyle(
      //                 fontSize: 12.sp,
      //                 color: Colors.grey,
      //               ),
      //             ),
      //             SizedBox(height: 5.h),
      //             Text(
      //               job['title'] ?? '', // Access the 'title' key
      //               style: TextStyle(
      //                 fontSize: 20.sp,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ],
      //         ),
      //         subtitle: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //                 job['description'] ?? ''), // Access the 'description' key
      //             SizedBox(height: 5.h),
      //             Row(
      //               children: [
      //                 _buildCircularButton(
      //                     job['type'] ?? ''), // Access the 'type' key
      //                 SizedBox(width: 8.w),
      //                 _buildCircularButton(
      //                     job['level'] ?? ''), // Access the 'level' key
      //                 SizedBox(width: 8.w),
      //                 _buildCircularButton(
      //                     job['pay'] ?? ''), // Access the 'pay' key
      //               ],
      //             ),
      //           ],
      //         ),
      //         trailing: const Icon(Icons.favorite_border, color: Colors.black),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => JobDetailsScreen(jobDetails: job),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCircularButton(String text) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(30.r),
//         border: Border.all(color: Colors.black),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: 12.sp,
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
// }
