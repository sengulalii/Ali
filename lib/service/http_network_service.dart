import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:zoom_ders1/service/abstract_network_service.dart';

class HttpNetworkService implements AbstractNetworkService {
  @override
  String? url = "https://random--user.me/api/?";

  @override
  Future getResults(int count, String path) async {
    try {
      if (count == 10) throw "ServiceError";
      print("getResults with Http");
      var url = Uri.parse("${this.url}$path=$count");
      var response = await http.get(url);
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print(e.runtimeType);
      //Sentry.sendException(path,username);
      rethrow; //Exception("Network Error");
    }
  }
}
