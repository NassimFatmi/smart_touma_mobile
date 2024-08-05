import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_touma_mobile/src/constants/api_config.dart';
import 'package:smart_touma_mobile/src/models/home_documents_model.dart';

class HomeService {
  Future<HomeDocumentsModel> getHomeData(String? token) async {
    try {
      final response = await http
          .get(Uri.parse('${ApiConfig.baseUrl}/screen-page'), headers: {
        'x-api-key': ApiConfig.apiKey,
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return HomeDocumentsModel.fromJson(json.decode(response.body));
      } else {
        throw ('Failed to load home data');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
