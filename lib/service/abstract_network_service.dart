abstract class AbstractNetworkService {
  String? url;
  Future getResults(int count, String path);
}
