class Tag {
  final String id;
  final String title;
  final String description;

  Tag({
    required this.id,
    required this.title,
    required this.description,
  });

  // Factory constructor to create a Tag from JSON
  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
