import 'dart:convert';

class Name {
  String? first;
  String? last;
  Name({
    this.first,
    this.last,
  });

  String get title {
    return (this.first ?? "") + " " + (this.last ?? "");
  }

  @override
  String toString() => 'Name(first: $first, last: $last)';

  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() {
    return {
      'first': first,
      'last': last,
    };
  }

  factory Name.fromJson(String source) {
    return Name.fromMap(json.decode(source));
  }

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      first: map['first'],
      last: map['last'],
    );
  }
}
