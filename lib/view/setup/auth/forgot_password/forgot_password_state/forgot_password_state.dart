import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';
part 'forgot_password_state.g.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    required String emailAddress,
    @Default(false) bool isLoading,
  }) = _ForgotPasswordState;

  factory ForgotPasswordState.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordStateFromJson(json);
}
