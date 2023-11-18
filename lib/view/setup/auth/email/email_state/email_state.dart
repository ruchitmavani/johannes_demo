import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_state.freezed.dart';
part 'email_state.g.dart';

@freezed
class EmailState with _$EmailState {
  const factory EmailState({
    @Default(false) bool isLoading,
    @Default(false) bool isChecked,
    required String emailAddress,
    required String password,
  }) = _EmailState;

  factory EmailState.fromJson(Map<String, dynamic> json) =>
      _$EmailStateFromJson(json);
}
