import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheqlee_app/screens/searchscreen.dart';
import 'package:sheqlee_app/data/dummy_jobs.dart';
import 'job_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  bool _isScrolled = false;
  bool _isUpdating = false;
  bool _isLoadingJobs = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _scrollController.addListener(() {
      if (_scrollController.offset > 100 && !_isScrolled) {
        setState(() {
          _isScrolled = true;
        });
      } else if (_scrollController.offset <= 100 && _isScrolled) {
        setState(() {
          _isScrolled = false;
        });
      }

      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoadingMore) {
        _loadMoreJobs();
      }
    });

    _loadInitialJobs();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialJobs() async {
    setState(() {
      _isLoadingJobs = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoadingJobs = false;
    });
  }

  Future<void> _loadMoreJobs() async {
    setState(() {
      _isLoadingMore = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoadingMore = false;
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isUpdating = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isUpdating = false;
    });
  }

  Widget _buildJobLoader() {
    return Align(
      alignment: Alignment.topCenter,
      child: RotationTransition(
        turns: _animationController,
        child: Icon(
          FeatherIcons.loader,
          size: 30.w,
          color: const Color.fromARGB(255, 137, 103, 179),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _isLoadingJobs
                ? _buildJobLoader()
                : RefreshIndicator(
                    onRefresh: _handleRefresh,
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.zero, // Remove unnecessary spacing
                      itemCount: dummyJobs.length + (_isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (_isUpdating && index == 0) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Center(
                              child: RotationTransition(
                                turns: _animationController,
                                child: Icon(
                                  FeatherIcons.loader,
                                  size: 30.w,
                                  color:  Color.fromARGB(255, 137, 103, 179),
                                ),
                              ),
                            ),
                          );
                        }

                        if (_isLoadingMore && index == dummyJobs.length) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Center(
                              child: RotationTransition(
                                turns: _animationController,
                                child: Icon(
                                  FeatherIcons.loader,
                                  size: 30.w,
                                  color: const Color.fromARGB(255, 137, 103, 179),
                                ),
                              ),
                            ),
                          );
                        }

                        final job = dummyJobs[index] as Map<String, dynamic>;
                        return Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 8.h, // Adjust vertical margins
                            horizontal: 10.w,
                          ),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job['timeAgo'] ?? '',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  job['title'] ?? '',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(job['description'] ?? ''),
                                SizedBox(height: 5.h),
                                Row(
                                  children: [
                                    _buildCircularButton(job['type'] ?? ''),
                                    SizedBox(width: 8.w),
                                    _buildCircularButton(job['level'] ?? ''),
                                    SizedBox(width: 8.w),
                                    _buildCircularButton(job['pay'] ?? ''),
                                  ],
                                ),
                              ],
                            ),
                            trailing: const Icon(Icons.favorite_border, color: Colors.black),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobDetailsScreen(
                                    jobDetails: dummyJobs[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: _isScrolled
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(jobs: dummyJobs),
                  ),
                );
              },
              backgroundColor:  Color.fromARGB(255, 137, 103, 179),
              shape: const CircleBorder(),
              child: const Icon(Icons.search, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildCircularButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.black),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
