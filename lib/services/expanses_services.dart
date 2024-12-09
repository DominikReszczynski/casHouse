import 'dart:convert';

import 'package:cas_house/api_service.dart';
import 'package:cas_house/models/expanses.dart';
import 'package:http/http.dart' as http;

class ExpansesServices {
  final String _urlPrefix = ApiService.baseUrl;

  addExpanse(Expanses expanse) async {
    print('test');
    Map<String, dynamic> body = {
      'expanse': expanse,
    };
    print(_urlPrefix);
    // final response = await http.post(Uri.parse('$_urlPrefix/expanse/add'));
    final http.Response res = await http.post(
      Uri.parse('$_urlPrefix/expanse/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    print(res.toString());
    Map<String, dynamic> decodedBody = json.decode(res.body);
    print(decodedBody);
    if (decodedBody['success']) {
      Expanses expanse = Expanses.fromJson(decodedBody['expanse']);
      return expanse;
    }
  }
}
