// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ForgotPasswordStateImpl _$$ForgotPasswordStateImplFromJson(
        Map<String, dynamic> json) =>
    _$ForgotPasswordStateImpl(
      isLoading: json['isLoading'] as bool? ?? false,
      emailAddress: json['emailAddress'] as String,
    );

Map<String, dynamic> _$$ForgotPasswordStateImplToJson(
        _$ForgotPasswordStateImpl instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'emailAddress': instance.emailAddress,
    };
