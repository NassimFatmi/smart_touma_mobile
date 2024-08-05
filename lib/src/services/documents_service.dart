import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:smart_touma_mobile/src/constants/api_config.dart';
import 'package:smart_touma_mobile/src/models/document_model.dart';
import 'package:http/http.dart' as http;

class DocumentsService {
  Future<List<Document>?> getDocuments(
      {String? token, int? pageSize = 5}) async {
    try {
      final response = await http.get(
          Uri.parse('${ApiConfig.baseUrl}/documents?pageSize=$pageSize'),
          headers: {
            'x-api-key': ApiConfig.apiKey,
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = json.decode(response.body);
        final documentsList = result['documents'] as List;
        List<Document> documents =
            documentsList.map((e) => Document.fromJson(e)).toList();

        return documents;
      } else {
        throw Exception('Failed to load documents');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool?> createDocument(String? token, XFile image) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiConfig.baseUrl}/documents'),
      );

      request.headers.addAll({
        'x-api-key': ApiConfig.apiKey,
        'Authorization': 'Bearer $token',
      });

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          image.path,
        ),
      );

      final response = await request.send();

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to create document');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Document?> updateDocument(
      String? token, String userPrompt, Document document) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/documents/${document.id}'),
        headers: {
          'x-api-key': ApiConfig.apiKey,
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'user_prompt': userPrompt,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = json.decode(response.body);
        return Document.fromJson(result);
      } else {
        throw Exception('Failed to update document');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteDocument(String? token, String id) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}/documents/$id'),
        headers: {
          'x-api-key': ApiConfig.apiKey,
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete document');
      }

      return;
    } catch (e) {
      rethrow;
    }
  }
}
