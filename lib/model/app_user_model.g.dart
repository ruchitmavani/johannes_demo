// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      phoneNo: json['phoneNo'] as String?,
      dob: const MilliSecondConverter().fromJson(json['dob'] as int),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gender': _$GenderEnumMap[instance.gender]!,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'email': instance.email,
      'phoneNo': instance.phoneNo,
      'dob': const MilliSecondConverter().toJson(instance.dob),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

const _$GenderEnumMap = {
  Gender.male: 'Male',
  Gender.female: 'Female',
};
