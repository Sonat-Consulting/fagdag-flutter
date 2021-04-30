class Observation {
  final int? id;
  final String userId;
  final String title;
  final String? description;
  final String imageUrl;

  Observation({
    this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.imageUrl,
  });

  factory Observation.fromJson(Map<String, dynamic> json) {
    return Observation(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
