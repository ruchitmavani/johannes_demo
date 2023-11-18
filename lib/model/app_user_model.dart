import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:johannes_demo/constants/enums.dart';

part 'app_user_model.freezed.dart';

part 'app_user_model.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required Gender gender,
    required String imageUrl,
    required String name,
    required String? email,
    required String? phoneNo,
    @MilliSecondConverter() required DateTime dob,
    @TimestampConverter() required DateTime createdAt,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

class MilliSecondConverter implements JsonConverter<DateTime, int> {
  const MilliSecondConverter();

  @override
  DateTime fromJson(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  @override
  int toJson(DateTime date) => date.millisecondsSinceEpoch;
}
