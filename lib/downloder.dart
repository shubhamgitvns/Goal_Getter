import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class Utilities {
  static Future Downloaddata(String link) async {
    final url = Uri.https(
        "ltss.pocketmoney.net.in",
        link,
        {
          // 'Mobile':App_Text.number.text
        } as Map<String, dynamic>?);
    try {
      final response = await http.post(url);
      //print("Response $response");
      print("status${response.statusCode}");
      print("Body${response.body}");

      final jsonResponse = convert.jsonDecode(response.body);

      print(jsonResponse.runtimeType);
      return jsonResponse;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
