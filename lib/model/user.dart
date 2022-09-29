import 'enum_gender.dart';
import 'name.dart';

class User {
  Gender? gender;
  Name? name;
  String? picture;

  User({
    required this.picture,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      picture: map["picture"] != null ? map["picture"]["large"] : null,
    );
  }
}
