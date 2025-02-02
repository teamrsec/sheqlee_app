import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheqlee_app/constants/custom_back_button.dart';
import 'package:sheqlee_app/widgets/custom_dropdown.dart';
import 'package:sheqlee_app/widgets/custom_text_field.dart';
import 'package:sheqlee_app/widgets/custom_text_form_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final FocusNode _fullNameFocusNode = FocusNode();
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final TextEditingController _introductionController = TextEditingController();
  final FocusNode _introductionFocusNode = FocusNode();
  final TextEditingController _skillsController = TextEditingController();
  final FocusNode _skillsFocusNode = FocusNode();
  final TextEditingController _profilesController = TextEditingController();
  final FocusNode _profilesFocusNode = FocusNode();
  bool isFullNameFilled = false;
  bool isTitleFilled = false;
  bool isIntroductionFilled = false;
  bool isSkillsFilled = false;
  bool isProfilesFilled = false;
  bool isUpdateButtonEnabled = false;

  void _showAddSkillDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedSkill;
        String? selectedLevel;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              title: Center(
                child: Text(
                  'Add a new skill',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Skill Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDropdown(
                        dialog: true,
                        label: 'Skill',
                        items: [
                          'Java',
                          'Flutter',
                          'Rust',
                          'C++',
                          'C',
                          'JavaScript',
                          'React.js',
                          'Dart',
                          'Swift',
                          'Kotlin'
                        ],
                        width: 0.644,
                        selectedValue: selectedSkill,
                        onChanged: (value) {
                          setState(() {
                            selectedSkill = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h), // Add spacing between dropdowns

                  // Level Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDropdown(
                        dialog: true,
                        label: 'Level',
                        items: [
                          'Beginner',
                          'Intermediate',
                          'Advanced',
                          'Expert'
                        ],
                        selectedValue: selectedLevel,
                        width: 0.644,
                        onChanged: (value) {
                          setState(() {
                            selectedLevel = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 16.h),
                        side: BorderSide(
                          color: const Color.fromARGB(255, 137, 103, 179),
                          width: 2.w,
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: const Color.fromARGB(255, 137, 103, 179)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed:
                          (selectedSkill != null && selectedLevel != null)
                              ? () {
                                  Navigator.of(context).pop();
                                }
                              : null,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 46.w, vertical: 16.h),
                        backgroundColor:
                            (selectedSkill != null && selectedLevel != null)
                                ? const Color.fromARGB(255, 137, 103, 179)
                                : Colors.black,
                        disabledBackgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                      ),
                      child: Text(
                        'Add Skill',
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String platform = '';
        String url = '';

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              title: Center(
                child: Text(
                  'Add a new profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    width: 0.7,
                    hint: 'Platform',
                    onChanged: (value) {
                      setState(() {
                        platform = value;
                      });
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    width: 0.7,
                    hint: 'URL',
                    onChanged: (value) {
                      setState(() {
                        url = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 16.h),
                        side: BorderSide(
                          color: const Color.fromARGB(255, 137, 103, 179),
                          width: 2.w,
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: const Color.fromARGB(255, 137, 103, 179)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (platform.isNotEmpty && url.isNotEmpty)
                          ? () {
                              // Add profile functionality
                              Navigator.of(context).pop();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.w, vertical: 16.h),
                        backgroundColor: (platform.isNotEmpty && url.isNotEmpty)
                            ? const Color.fromARGB(255, 137, 103, 179)
                            : Colors.black,
                        disabledBackgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                      ),
                      child: Text(
                        'Add Profile',
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to prevent memory leaks
    _fullNameController.dispose();
    _fullNameFocusNode.dispose();
    _titleController.dispose();
    _titleFocusNode.dispose();
    _introductionController.dispose();
    _introductionFocusNode.dispose();
    _skillsController.dispose();
    _skillsFocusNode.dispose();
    _profilesController.dispose();
    _profilesFocusNode.dispose();
    super.dispose();
  }

  void _handleFieldChanged(bool isFilled, String field) {
    setState(() {
      // Update the state of the specific field
      if (field == "fullName") {
        isFullNameFilled = isFilled;
      } else if (field == "title") {
        isTitleFilled = isFilled;
      } else if (field == "introduction") {
        isIntroductionFilled = isFilled;
      } else if (field == "profiles") {
        isProfilesFilled = isFilled;
      } else if (field == "skills") {
        isSkillsFilled = isFilled;
      }

      // Update the button state based on all fields
      isUpdateButtonEnabled = isFullNameFilled &&
          isTitleFilled &&
          isIntroductionFilled &&
          isProfilesFilled &&
          isSkillsFilled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const CustomBackButton(),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontFamily: 'pretendard',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 75.r,
                        height: 75.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // Add photo functionality
                          },
                          child: CircleAvatar(
                            radius: 37.r,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              'assets/images/settings - alt2@3x.png',
                              fit: BoxFit.cover,
                              width: 30.w,
                              height: 30.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Add a photo',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 137, 103, 179),
                              fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  Stack(
                    children: [
                      CustomTextFormField(
                        focusNode: _fullNameFocusNode,
                        controller: _fullNameController,
                        labelText: 'Full Name',
                        hintText: 'Your full name',
                        isMandatory: true,
                        showCharacterCounter: false,
                        onChanged: (value) {
                          _handleFieldChanged(value.isNotEmpty, "fullName");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Stack(
                    children: [
                      CustomTextFormField(
                        focusNode: _titleFocusNode,
                        controller: _titleController,
                        labelText: 'Title',
                        hintText: 'Professional headline',
                        isMandatory: true,
                        showCharacterCounter: false,
                        onChanged: (value) {
                          _handleFieldChanged(value.isNotEmpty, "title");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Stack(
                    children: [
                      CustomTextFormField(
                        focusNode: _introductionFocusNode,
                        controller: _introductionController,
                        labelText: 'Introduction',
                        hintText: 'A brief introduction about yourself',
                        isMandatory: false,
                        showCharacterCounter: true,
                        maxLines: 5,
                        maxLength: 256,
                        onChanged: (value) {
                          _handleFieldChanged(value.isNotEmpty, "introduction");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Stack(
                    children: [
                      CustomTextFormField(
                        focusNode: _skillsFocusNode,
                        controller: _skillsController,
                        labelText: 'Skills',
                        hintText: 'Skills such as Java and Flutter',
                        isMandatory: false,
                        showCharacterCounter: false,
                        maxLines: 4,
                        onChanged: (value) {
                          _handleFieldChanged(value.isNotEmpty, "skills");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showAddSkillDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 137, 103, 179),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: const Text(
                          'Add skill',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Stack(
                    children: [
                      CustomTextFormField(
                        focusNode: _profilesFocusNode,
                        controller: _profilesController,
                        labelText: 'Profiles',
                        hintText: 'Profiles such as LinkedIn and GitHub',
                        isMandatory: false,
                        showCharacterCounter: false,
                        maxLines: 4,
                        onChanged: (value) {
                          _handleFieldChanged(value.isNotEmpty, "Profiles");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showAddProfileDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 137, 103, 179),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: const Text(
                          'Add profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isUpdateButtonEnabled ? () {} : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isUpdateButtonEnabled
                        ? const Color.fromARGB(255, 137, 103, 179)
                        : Colors.black,
                    disabledBackgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    'Update Profile',
                    style: TextStyle(color: Colors.white,fontSize: 20.sp),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
