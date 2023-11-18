import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:phone_form_field/phone_form_field.dart';

part 'phone_state.freezed.dart';

part 'phone_state.g.dart';

@freezed
class PhoneState with _$PhoneState {
  const factory PhoneState({
    @Default(false) bool isLoading,
    @Default(false) bool isOtpSent,
    @Default(false) bool dummy,
    required String phone,
    required String otp,
    required String verificationId,
    required IsoCode isoCode,
  }) = _PhoneState;

  factory PhoneState.fromJson(Map<String, dynamic> json) =>
      _$PhoneStateFromJson(json);
}
