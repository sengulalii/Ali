import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class NetworkService {
  static const String _url = "https://randomuser.me/api/?";

  static Future getResults(int count, String path) async {
    print("getResults");
    var url = Uri.parse("${_url}$path=$count");
    var response = await http.get(url);
    return convert.jsonDecode(response.body) as Map<String, dynamic>;
  }
}
