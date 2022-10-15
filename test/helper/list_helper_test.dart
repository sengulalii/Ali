import 'package:flutter_test/flutter_test.dart';
import 'package:zoom_ders1/helper/list_helper.dart';

main() {
  group("Clearing any lists", () {
    test("Clearing non-null list", () {
      // A: Arrange
      List<int> intList = [4, 7];
      // A: Act
      intList = ListHelper.removeAllItems(intList);
      // A: Assert
      expect(intList, equals([]));
    });

    test("Clearing null list", () {
      // A: Arrange
      List? nullList;
      // A: Act
      nullList = ListHelper.removeAllItems(nullList);
      // A: Assert
      expect(nullList, equals([]));
    });
  });
}
