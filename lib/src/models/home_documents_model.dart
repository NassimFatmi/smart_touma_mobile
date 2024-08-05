import 'package:smart_touma_mobile/src/models/document_category_model.dart';
import 'package:smart_touma_mobile/src/models/document_model.dart';
import 'package:smart_touma_mobile/src/models/template_model.dart';

class HomeDocumentsModel {
  List<Document> recentDocuments;
  List<Document> sharedDocuments;
  List<DocumentCategory> latestCategories;
  List<Template> latestTemplates;

  HomeDocumentsModel({
    required this.recentDocuments,
    required this.sharedDocuments,
    required this.latestCategories,
    required this.latestTemplates,
  });

  factory HomeDocumentsModel.fromJson(Map<String, dynamic> json) {
    return HomeDocumentsModel(
      recentDocuments: List<Document>.from(
          json['recentDocuments'].map((x) => Document.fromJson(x))),
      sharedDocuments: List<Document>.from(
          json['sharedDocuments'].map((x) => Document.fromJson(x))),
      latestCategories: List<DocumentCategory>.from(
          json['latestCategories'].map((x) => DocumentCategory.fromJson(x))),
      latestTemplates: List<Template>.from(
          json['latestTemplates'].map((x) => Template.fromJson(x))),
    );
  }
}
