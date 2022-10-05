import 'package:flutter/material.dart';

import '../model/user.dart';
import '../service/network_service.dart';

class ContentViewModel extends ChangeNotifier {
  List<User> users = [];

  Future<void> get5Users() async {
    late var jsonResponse;
    jsonResponse = await NetworkService.getResults(5, "results");

    for (var i = 0; i < jsonResponse["results"].length; i++) {
      var currentUser = User.fromJson(jsonResponse["results"][i]);
      users.add(currentUser);
    }
    notifyListeners();
  }

  Future<void> get10Users() async {
    late var jsonResponse;
    jsonResponse = await NetworkService.getResults(10, "results");
    for (var i = 0; i < jsonResponse["results"].length; i++) {
      var currentUser = User.fromJson(jsonResponse["results"][i]);
      users.add(currentUser);
    }
    notifyListeners();
  }

  void clearUsers() {
    users = [];
    notifyListeners();
  }

  void removeUsers() {
    users = [];
  }

  void removeLast() {
    users.removeLast();
    notifyListeners();
  }
}
