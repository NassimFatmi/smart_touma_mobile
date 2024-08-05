class Template {
  String id;
  String preview;
  String name;
  DateTime createdAt;

  Template({
    required this.id,
    required this.preview,
    required this.name,
    required this.createdAt,
  });

  factory Template.fromJson(Map<String, dynamic> json) {
    return Template(
      id: json['id'],
      preview: json['preview'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
