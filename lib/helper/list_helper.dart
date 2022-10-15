class ListHelper {
  static List<T> removeAllItems<T>(List<T>? list) {
    list?.clear();
    return list ?? <T>[];
  }
}
