import 'package:json_annotation/json_annotation.dart';
import 'enum_gender.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  Gender? gender;
  //Name? name;
  String? picture;

  User({this.picture});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /* factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: Name.fromJson(map["first"]),
      picture: map["picture"] != null ? map["picture"]["large"] : null,
    );
  }*/
}
