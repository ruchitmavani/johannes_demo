// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EmailState _$EmailStateFromJson(Map<String, dynamic> json) {
  return _EmailState.fromJson(json);
}

/// @nodoc
mixin _$EmailState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isChecked => throw _privateConstructorUsedError;
  String get emailAddress => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmailStateCopyWith<EmailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailStateCopyWith<$Res> {
  factory $EmailStateCopyWith(
          EmailState value, $Res Function(EmailState) then) =
      _$EmailStateCopyWithImpl<$Res, EmailState>;
  @useResult
  $Res call(
      {bool isLoading, bool isChecked, String emailAddress, String password});
}

/// @nodoc
class _$EmailStateCopyWithImpl<$Res, $Val extends EmailState>
    implements $EmailStateCopyWith<$Res> {
  _$EmailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isChecked = null,
    Object? emailAddress = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      emailAddress: null == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailStateImplCopyWith<$Res>
    implements $EmailStateCopyWith<$Res> {
  factory _$$EmailStateImplCopyWith(
          _$EmailStateImpl value, $Res Function(_$EmailStateImpl) then) =
      __$$EmailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading, bool isChecked, String emailAddress, String password});
}

/// @nodoc
class __$$EmailStateImplCopyWithImpl<$Res>
    extends _$EmailStateCopyWithImpl<$Res, _$EmailStateImpl>
    implements _$$EmailStateImplCopyWith<$Res> {
  __$$EmailStateImplCopyWithImpl(
      _$EmailStateImpl _value, $Res Function(_$EmailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isChecked = null,
    Object? emailAddress = null,
    Object? password = null,
  }) {
    return _then(_$EmailStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      emailAddress: null == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailStateImpl implements _EmailState {
  const _$EmailStateImpl(
      {this.isLoading = false,
      this.isChecked = false,
      required this.emailAddress,
      required this.password});

  factory _$EmailStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailStateImplFromJson(json);

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isChecked;
  @override
  final String emailAddress;
  @override
  final String password;

  @override
  String toString() {
    return 'EmailState(isLoading: $isLoading, isChecked: $isChecked, emailAddress: $emailAddress, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isChecked, isChecked) ||
                other.isChecked == isChecked) &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, isChecked, emailAddress, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailStateImplCopyWith<_$EmailStateImpl> get copyWith =>
      __$$EmailStateImplCopyWithImpl<_$EmailStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailStateImplToJson(
      this,
    );
  }
}

abstract class _EmailState implements EmailState {
  const factory _EmailState(
      {final bool isLoading,
      final bool isChecked,
      required final String emailAddress,
      required final String password}) = _$EmailStateImpl;

  factory _EmailState.fromJson(Map<String, dynamic> json) =
      _$EmailStateImpl.fromJson;

  @override
  bool get isLoading;
  @override
  bool get isChecked;
  @override
  String get emailAddress;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$EmailStateImplCopyWith<_$EmailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
