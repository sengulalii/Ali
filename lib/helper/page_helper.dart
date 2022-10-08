import 'dart:ui';

import 'package:flutter/material.dart';

/* class */ mixin PageHelper {
  /* static */ void printPageData(String pageName) {
    print("Sayfa adı:+ $pageName");
  }

  Color color = Colors.white;
}
