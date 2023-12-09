import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class BaseNetwork {
  static const String baseUrl = "https://www.themealdb.com/api/json/v1/1";

  static Future<Map<String, dynamic>> get(String partUrl) async {
    final String fullUrl = "$baseUrl/$partUrl";
    debugPrint("BaseNetwork - fullUrl : $fullUrl");
    final response = await http.get(Uri.parse(fullUrl));
    debugPrint("BaseNetwork - response : ${response.body}");
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> _processResponse(
      http.Response response) async {
    final body = response.body;
    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      return jsonBody;
    } else {
      log("processResponse error");
      return {"error": true};
    }
  }

  static void debugPrint(String value) {
    log("[BASE_NETWORK] - $value");
  }
}