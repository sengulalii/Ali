import 'package:dio/dio.dart';
import 'package:zoom_ders1/service/abstract_network_service.dart';

class DioNetworkService implements AbstractNetworkService {
  @override
  String? url = "https://randomuser.me/api/?";

  @override
  Future getResults(int count, String path) async {
    try {
      print("getResults with Dio");
      var url = "${this.url}$path=$count";
      var response = await Dio().get(url);
      return response;
    } catch (e) {
      //Sentry.sendException(path,username);
      throw Exception("Network Error");
    }
  }
}
