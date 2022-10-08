// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      picture: json['picture']['large'] as String?,
    )..gender = $enumDecodeNullable(_$GenderEnumMap, json['gender']);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'gender': _$GenderEnumMap[instance.gender],
      'picture': instance.picture,
    };

const _$GenderEnumMap = {
  Gender.female: 'female',
  Gender.male: 'male',
};
