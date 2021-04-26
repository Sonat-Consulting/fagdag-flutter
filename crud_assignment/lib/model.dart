class Observation {
  final int? id;
  final String userId;
  final String title;
  final String? description;

  Observation({
    this.id,
    required this.userId,
    required this.title,
    this.description,
  });

  factory Observation.fromJson(Map<String, dynamic> json) {
    return Observation(
      id: json['id']!,
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
    );
  }
}
