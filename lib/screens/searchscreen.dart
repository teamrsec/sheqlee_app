import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheqlee_app/constants/custom_back_button.dart';
import 'package:sheqlee_app/data/dummy_jobs.dart';
import 'package:sheqlee_app/screens/filterscreen.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, dynamic>> jobs;

  const SearchScreen({super.key, required this.jobs});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> _filteredJobs = [];
  List<String> autocompleteSuggestions = [];
  List<String> _tags = []; // Store tag titles
  bool _isLoadingTags = true; // Track loading state for tags

  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _filteredJobs = widget.jobs; // Initially display all jobs
    _fetchTags();

    // Listen to changes in the search input
    _searchController.addListener(() {
      _filterJobs(_searchController.text);
    });

    // Listen for focus change to hide all components when search is focused
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  void _updateAutocomplete(String query) {
    setState(() {
      autocompleteSuggestions = dummyJobs
          .where((job) => job['title']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .map((job) => job['title'].toString())
          .toList();
    });
  }

  // Filter jobs based on search query (now search anywhere in title)
  void _filterJobs(String query) {
    setState(() {
      // Filter jobs based on the query matching anywhere in the title
      _filteredJobs = widget.jobs
          .where((job) => job['title']
              .toLowerCase()
              .contains(query.toLowerCase())) // Search anywhere in the title
          .toList();

      // Generate suggestions based on the query (match anywhere in the title)
      autocompleteSuggestions = widget.jobs
          .where((job) => job['title']
              .toLowerCase()
              .contains(query.toLowerCase())) // Suggestions based on query
          .map((job) => job['title'] as String)
          .toList();
    });
  }

  Future<void> _fetchTags() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.137.1:3000/api.sheqlee.com/v1/tags'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> tagsData = jsonData['data']['tags'];

        // Debug: Print fetched tags
        print('Fetched tags: $tagsData');

        setState(() {
          _tags = tagsData
              .take(10) // Limit to 10 tags
              .map((tag) => tag['title'].toString())
              .toList();
          _isLoadingTags = false;
        });
      } else {
        throw Exception(
            'Failed to fetch tags. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      setState(() {
        _isLoadingTags = false;
      });
      print('Error fetching tags: $error');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Search Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    height: 50.h,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode, // FocusNode to manage focus
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Image.asset('assets/images/search.png',
                              width: 20.w, height: 20.h),
                          onPressed: () {},
                        ), // Search icon
                        hintText: 'Search',
                        hintStyle:
                            TextStyle(color: Colors.black, fontSize: 16.sp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                  ),
                ),

                // Circular Filter Button
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterScreen(), // Pass the jobs list
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black), // Black border
                      shape: const CircleBorder(), // Circular shape
                      padding: EdgeInsets.zero, // Remove default padding
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/filter - alt2@3x.png', // Replace with your filter icon path
                        width: 30.w,
                        height: 25.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Show suggestions when the user is typing
            if (_isSearchFocused && _searchController.text.isNotEmpty) ...[
              // Suggestions List
              Expanded(
                child: ListView.builder(
                  itemCount: autocompleteSuggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.search),
                      title: Text(autocompleteSuggestions[index]),
                      onTap: () {
                        _searchController.text = autocompleteSuggestions[index];
                        _filterJobs(autocompleteSuggestions[index]);
                      },
                    );
                  },
                ),
              ),
            ] else if (!_isSearchFocused) ...[
              if (_isLoadingTags) ...[
                const Center(child: CircularProgressIndicator()),
              ] else if (_tags.isEmpty) ...[
                const Center(child: Text('No tags available')),
              ] else ...[
                Wrap(
                  spacing: 10.w,
                  runSpacing: 5.h,
                  children: _tags.map((tag) => _buildTagButton(tag)).toList(),
                ),
              ],

              SizedBox(height: 20.h),

              // Categories List
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredJobs.length,
                  itemBuilder: (context, index) {
                    final job = _filteredJobs[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            job['title'],
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.black),
                          ),
                          trailing: Transform(
                            alignment: Alignment.centerRight,
                            transform: Matrix4.identity()
                              ..scale(-1.0, 1.0), // Flip horizontally
                            child: Image.asset(
                              'assets/images/arrow-down-sign-to-navigate.png',
                              width: 10.02.w,
                              height: 11.5.h,
                              color: const Color.fromARGB(255, 160, 160, 160),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTagButton(String tagName) {
    print('Rendering tag: $tagName'); // Debug: Check what's being rendered

    return Container(
      height: 35.h,
      child: OutlinedButton(
        onPressed: () {
          // Handle tag press
          print('Tag pressed: $tagName');
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black),
          shape: const StadiumBorder(),
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        ),
        child: Text(
          tagName,
          style: TextStyle(color: Colors.black, fontSize: 12.sp),
        ),
      ),
    );
  }
}