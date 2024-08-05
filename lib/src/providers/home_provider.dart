import 'package:flutter/material.dart';
import 'package:smart_touma_mobile/src/models/home_documents_model.dart';
import 'package:smart_touma_mobile/src/services/auth_service.dart';
import 'package:smart_touma_mobile/src/services/home_service.dart';

class HomeProvider extends ChangeNotifier {
  final HomeService _homeService = HomeService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  HomeDocumentsModel? _homeData;

  HomeDocumentsModel? get homeData => _homeData;

  String? _error;

  String? get error => _error;
  void deleteError() {
    _error = null;
    notifyListeners();
  }

  Future<void> fetchHomeData() async {
    try {
      _isLoading = true;
      notifyListeners();

      final currentUser = AuthService.instance.currentUser;
      final String? token = await currentUser?.getIdToken();
      final HomeDocumentsModel homeData = await _homeService.getHomeData(token);

      _homeData = homeData;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
