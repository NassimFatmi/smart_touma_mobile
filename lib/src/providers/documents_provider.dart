import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_touma_mobile/src/models/document_model.dart';
import 'package:smart_touma_mobile/src/services/auth_service.dart';
import 'package:smart_touma_mobile/src/services/documents_service.dart';

class DocumentsProvider with ChangeNotifier {
  final DocumentsService _documentsSer = DocumentsService();

  List<Document> _documents = <Document>[];

  List<Document> get documents => _documents;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  void getDocuments() async {
    try {
      _isLoading = true;
      notifyListeners();

      final currentUser = AuthService.instance.currentUser;
      final String? token = await currentUser?.getIdToken();

      final List<Document>? documentsList = await _documentsSer.getDocuments(
        token: token,
      );

      if (documentsList != null) _documents = documentsList;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> createDocument(XFile image) async {
    try {
      _isLoading = true;
      notifyListeners();

      final currentUser = AuthService.instance.currentUser;
      final String? token = await currentUser?.getIdToken();

      final bool? document = await _documentsSer.createDocument(token, image);

      if (document == true) getDocuments();
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteDocument(String id) async {
    try {
      _isLoading = true;
      notifyListeners();

      final currentUser = AuthService.instance.currentUser;
      final String? token = await currentUser?.getIdToken();

      await _documentsSer.deleteDocument(token, id);

      _documents.removeWhere((element) => element.id == id);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateDocument(String userPrompt, Document document) async {
    try {
      _isLoading = true;
      notifyListeners();

      final currentUser = AuthService.instance.currentUser;
      final String? token = await currentUser?.getIdToken();

      final edited =
          await _documentsSer.updateDocument(token, userPrompt, document);

      if (edited != null) {
        final index =
            _documents.indexWhere((element) => element.id == edited.id);
        _documents[index] = edited;
      }
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
