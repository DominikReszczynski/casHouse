import 'dart:convert';

import 'package:cas_house/api_service.dart';
import 'package:cas_house/main_global.dart';
import 'package:http/http.dart' as http;

class DashboardServices {
  final String _urlPrefix = ApiService.baseUrl;

  chat() async {
    print('DashboardServices');
    Map<String, dynamic> body = {'userID': loggedUser!.id};
    print(_urlPrefix);
    final http.Response res = await http.post(
      Uri.parse('$_urlPrefix/dashboard/chat'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    Map<String, dynamic> decodedBody = json.decode(res.body);
    print(decodedBody);
    if (decodedBody['success']) {
      String text = decodedBody['text'][0]['text'];
      return text;
    }
  }
}
