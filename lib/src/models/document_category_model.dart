class DocumentCategory {
  String id;
  String userId;
  String name;
  String description;
  DateTime createdAt;

  DocumentCategory({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  factory DocumentCategory.fromJson(Map<String, dynamic> json) {
    return DocumentCategory(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Copy With
  DocumentCategory copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    DateTime? createdAt,
  }) {
    return DocumentCategory(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
