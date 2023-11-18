// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:johannes_demo/model/app_user_model.dart';

// Project imports:

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({required AppUser? user}) = _AppState;
}
