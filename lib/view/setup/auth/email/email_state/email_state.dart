import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_state.freezed.dart';
part 'email_state.g.dart';

@freezed
class EmailState with _$EmailState {
  const factory EmailState({
    required String emailAddress,
    required String password,
    @Default(false) bool isLoading,
    @Default(false) bool isChecked,
  }) = _EmailState;

  factory EmailState.fromJson(Map<String, dynamic> json) =>
      _$EmailStateFromJson(json);
}
