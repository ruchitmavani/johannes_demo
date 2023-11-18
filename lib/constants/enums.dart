import 'package:freezed_annotation/freezed_annotation.dart';

enum Gender {
  @JsonValue('Male')
  male('Male'),
  @JsonValue('Female')
  female('Female');

  const Gender(this.name);

  final String name;
}
