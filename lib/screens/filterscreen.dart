import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheqlee_app/constants/custom_back_button.dart';
import 'package:sheqlee_app/data/dummy_jobs.dart';
import 'package:sheqlee_app/widgets/custom_dropdown.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? selectedCategory;
  String? selectedType;
  String? selectedLevel;
 // Function to check if all preferences are selected
  bool isAllPreferencesSelected() {
    return selectedCategory != null && selectedType != null && selectedLevel != null;
  }
  // Function to get unique categories from job titles
  List<String> getCategories() {
    return dummyJobs
        .map((job) => job['title'] as String)
        .toSet() // Remove duplicates
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left Column: Dropdowns
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Categories Dropdown
                    CustomDropdown(
                      dialog: false,
                      label: 'Categories',
                      width: 0.7,
                      selectedValue: selectedCategory,
                      items: getCategories(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    ),
                    SizedBox(height: 10.h),

                    // Row: Types and Levels Dropdowns
                    Row(
                      children: [
                        // Types Dropdown
                        Expanded(
                          child: CustomDropdown(
                            dialog: false,
                            label: 'Types',
                            selectedValue: selectedType,
                            width: 0.322,
                            items: const [
                              'Full-time',
                              'Part-time',
                              'Contarct',
                              'Per diem',
                              'Temporary',
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedType = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 8.w),

                        // Levels Dropdown
                        Expanded(
                          child: CustomDropdown(
                            dialog: false,
                            label: 'Levels',
                            width: 0.322,
                            selectedValue: selectedLevel,
                            items: const [
                              'Junior',
                              'Senior',
                              'Expert',
                              'Lead',
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedLevel = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),

              // Right Column: Apply Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAllPreferencesSelected()
                    ? const Color.fromARGB(255,137, 103, 179) // Change to green when all preferences are selected
                    : Colors.black, // Default color
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                onPressed: () {
                  // Handle apply action
                  print("Category: $selectedCategory");
                  print("Type: $selectedType");
                  print("Level: $selectedLevel");
                },
                child: Text(
                  'Apply',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}