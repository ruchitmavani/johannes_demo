// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmailStateImpl _$$EmailStateImplFromJson(Map<String, dynamic> json) =>
    _$EmailStateImpl(
      isLoading: json['isLoading'] as bool? ?? false,
      isChecked: json['isChecked'] as bool? ?? false,
      emailAddress: json['emailAddress'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$EmailStateImplToJson(_$EmailStateImpl instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'isChecked': instance.isChecked,
      'emailAddress': instance.emailAddress,
      'password': instance.password,
    };
