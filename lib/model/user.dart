import 'enum_gender.dart';
import 'name.dart';

class User {
  Gender? gender;
  Name? name;
  String? picture;

  User({this.name, this.picture});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: Name(
        first: map["name"]["first"],
        last: map["name"]["last"],
      ),
      picture: map["picture"] != null ? map["picture"]["large"] : null,
    );
  }
}
