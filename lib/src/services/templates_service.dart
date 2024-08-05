import 'package:http/http.dart' as http;
import 'package:smart_touma_mobile/src/constants/api_config.dart';

class TemplatesService {
  Future<String> getTemplate(String? token) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/templates'),
        headers: {
          'Authorization': 'Bearer $token',
          'x-api-key': ApiConfig.apiKey,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load templates');
      }
    } catch (e) {
      rethrow;
    }
  }
}
