class Job {
  final String title;
  final String companyName;
  final String type; // e.g., Full-time, Part-time
  final String level; // e.g., Expert, Intermediate
  final String pay; // e.g., $25-$30/hr
  final String timeAgo; // e.g., 30m ago
  final String description;
  final List<String> qualifications;
  final List<String> experience;
  final List<String> skills;
  final String longDescription;

  Job({
    required this.title,
    required this.companyName,
    required this.type,
    required this.level,
    required this.pay,
    required this.timeAgo,
    required this.description,
    required this.qualifications,
    required this.experience,
    required this.skills,
    required this.longDescription,
  });

  // Factory constructor to create a Job object from a map (useful for parsing JSON)
  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      title: map['title'] as String,
      companyName: map['companyName'] as String,
      type: map['type'] as String,
      level: map['level'] as String,
      pay: map['pay'] as String,
      timeAgo: map['timeAgo'] as String,
      description: map['description'] as String,
      qualifications: List<String>.from(map['qualifications'] as List),
      experience: List<String>.from(map['experience'] as List),
      skills: List<String>.from(map['skills'] as List),
      longDescription: map['longDescription'] as String,
    );
  }

  // Method to convert a Job object into a map (useful for converting to JSON)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'companyName': companyName,
      'type': type,
      'level': level,
      'pay': pay,
      'timeAgo': timeAgo,
      'description': description,
      'qualifications': qualifications,
      'experience': experience,
      'skills': skills,
      'longDescription': longDescription,
    };
  }
}
