class Document {
  String id;
  String userId;
  List<dynamic> embedding;
  String title;
  String latexCode;
  String? category;
  List<dynamic> canAccess;
  DateTime createdAt;
  String? url;

  Document({
    required this.id,
    required this.userId,
    required this.embedding,
    required this.title,
    required this.latexCode,
    required this.category,
    required this.canAccess,
    required this.createdAt,
    this.url,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      userId: json['user_id'],
      embedding: json['embedding'],
      title: json['title'],
      latexCode: json['latex_code'],
      category: json['category'],
      canAccess: json['can_access'],
      createdAt: DateTime.parse(json['created_at']),
      url: json['url'],
    );
  }
}
