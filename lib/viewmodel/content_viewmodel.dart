import 'package:flutter/material.dart';
import 'package:zoom_ders1/service/dio_network_service.dart';

import '../config/config.dart';
import '../model/user.dart';

enum Services {
  users5,
  users10,
}

enum ServiceStatus {
  idle,
  inProgress,
  completed,
  error,
}

class ContentViewModel extends ChangeNotifier {
  List<User> users = [];

  Map<Services, ServiceStatus> statusMap = {
    Services.users5: ServiceStatus.idle,
    Services.users10: ServiceStatus.idle,
  };
  int activeSessionNumber = 0;
  int counterForGet5Users = 0;

  Color color = Colors.white;

  Future<void> get5Users() async {
    print("get5Users");
    counterForGet5Users += 1;

    if (statusMap[Services.users5] != ServiceStatus.idle) {
      return;
    }
    users.clear();
    statusMap[Services.users5] = ServiceStatus.idle;

    notifyListeners();
    late var jsonResponse;
    statusMap[Services.users5] = ServiceStatus.inProgress;

    notifyListeners();
    try {
      jsonResponse = await networkService.getResults(5, "results");
      for (var i = 0; i < jsonResponse["results"].length; i++) {
        var currentUser = User.fromJson(jsonResponse["results"][i]);
        users.add(currentUser);
      }
      statusMap[Services.users5] = ServiceStatus.completed;
    } catch (e) {
      statusMap[Services.users5] = ServiceStatus.error;
    }

    notifyListeners();
  }

  Future<void> get10Users() async {
    try {
      late var jsonResponse;
      jsonResponse = await networkService.getResults(10, "results");
      for (var i = 0; i < jsonResponse["results"].length; i++) {
        var currentUser = User.fromJson(jsonResponse["results"][i]);
        users.add(currentUser);
      }
      notifyListeners();
    } catch (e) {
      if (e is String && e == "ServiceError") {
        networkService = DioNetworkService();
      } else {
        rethrow;
      }
    }
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
