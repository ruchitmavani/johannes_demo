// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PhoneState _$PhoneStateFromJson(Map<String, dynamic> json) {
  return _PhoneState.fromJson(json);
}

/// @nodoc
mixin _$PhoneState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isOtpSent => throw _privateConstructorUsedError;
  bool get dummy => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;
  String get verificationId => throw _privateConstructorUsedError;
  IsoCode get isoCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhoneStateCopyWith<PhoneState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhoneStateCopyWith<$Res> {
  factory $PhoneStateCopyWith(
          PhoneState value, $Res Function(PhoneState) then) =
      _$PhoneStateCopyWithImpl<$Res, PhoneState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isOtpSent,
      bool dummy,
      String phone,
      String otp,
      String verificationId,
      IsoCode isoCode});
}

/// @nodoc
class _$PhoneStateCopyWithImpl<$Res, $Val extends PhoneState>
    implements $PhoneStateCopyWith<$Res> {
  _$PhoneStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isOtpSent = null,
    Object? dummy = null,
    Object? phone = null,
    Object? otp = null,
    Object? verificationId = null,
    Object? isoCode = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isOtpSent: null == isOtpSent
          ? _value.isOtpSent
          : isOtpSent // ignore: cast_nullable_to_non_nullable
              as bool,
      dummy: null == dummy
          ? _value.dummy
          : dummy // ignore: cast_nullable_to_non_nullable
              as bool,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      verificationId: null == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String,
      isoCode: null == isoCode
          ? _value.isoCode
          : isoCode // ignore: cast_nullable_to_non_nullable
              as IsoCode,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhoneStateImplCopyWith<$Res>
    implements $PhoneStateCopyWith<$Res> {
  factory _$$PhoneStateImplCopyWith(
          _$PhoneStateImpl value, $Res Function(_$PhoneStateImpl) then) =
      __$$PhoneStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isOtpSent,
      bool dummy,
      String phone,
      String otp,
      String verificationId,
      IsoCode isoCode});
}

/// @nodoc
class __$$PhoneStateImplCopyWithImpl<$Res>
    extends _$PhoneStateCopyWithImpl<$Res, _$PhoneStateImpl>
    implements _$$PhoneStateImplCopyWith<$Res> {
  __$$PhoneStateImplCopyWithImpl(
      _$PhoneStateImpl _value, $Res Function(_$PhoneStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isOtpSent = null,
    Object? dummy = null,
    Object? phone = null,
    Object? otp = null,
    Object? verificationId = null,
    Object? isoCode = null,
  }) {
    return _then(_$PhoneStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isOtpSent: null == isOtpSent
          ? _value.isOtpSent
          : isOtpSent // ignore: cast_nullable_to_non_nullable
              as bool,
      dummy: null == dummy
          ? _value.dummy
          : dummy // ignore: cast_nullable_to_non_nullable
              as bool,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      verificationId: null == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String,
      isoCode: null == isoCode
          ? _value.isoCode
          : isoCode // ignore: cast_nullable_to_non_nullable
              as IsoCode,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PhoneStateImpl implements _PhoneState {
  const _$PhoneStateImpl(
      {this.isLoading = false,
      this.isOtpSent = false,
      this.dummy = false,
      required this.phone,
      required this.otp,
      required this.verificationId,
      required this.isoCode});

  factory _$PhoneStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhoneStateImplFromJson(json);

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isOtpSent;
  @override
  @JsonKey()
  final bool dummy;
  @override
  final String phone;
  @override
  final String otp;
  @override
  final String verificationId;
  @override
  final IsoCode isoCode;

  @override
  String toString() {
    return 'PhoneState(isLoading: $isLoading, isOtpSent: $isOtpSent, dummy: $dummy, phone: $phone, otp: $otp, verificationId: $verificationId, isoCode: $isoCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isOtpSent, isOtpSent) ||
                other.isOtpSent == isOtpSent) &&
            (identical(other.dummy, dummy) || other.dummy == dummy) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.isoCode, isoCode) || other.isoCode == isoCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isOtpSent, dummy,
      phone, otp, verificationId, isoCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneStateImplCopyWith<_$PhoneStateImpl> get copyWith =>
      __$$PhoneStateImplCopyWithImpl<_$PhoneStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhoneStateImplToJson(
      this,
    );
  }
}

abstract class _PhoneState implements PhoneState {
  const factory _PhoneState(
      {final bool isLoading,
      final bool isOtpSent,
      final bool dummy,
      required final String phone,
      required final String otp,
      required final String verificationId,
      required final IsoCode isoCode}) = _$PhoneStateImpl;

  factory _PhoneState.fromJson(Map<String, dynamic> json) =
      _$PhoneStateImpl.fromJson;

  @override
  bool get isLoading;
  @override
  bool get isOtpSent;
  @override
  bool get dummy;
  @override
  String get phone;
  @override
  String get otp;
  @override
  String get verificationId;
  @override
  IsoCode get isoCode;
  @override
  @JsonKey(ignore: true)
  _$$PhoneStateImplCopyWith<_$PhoneStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
