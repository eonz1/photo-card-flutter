import 'package:json_annotation/json_annotation.dart';

part 'response_entity.g.dart';

@JsonSerializable(
    genericArgumentFactories: true, fieldRename: FieldRename.snake)
class ResponseEntity<T> {
  int? resultCode;
  T? result;
  String? resultMsg;

  ResponseEntity({this.resultCode, this.result, this.resultMsg});

  factory ResponseEntity.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ResponseEntityFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ResponseEntityToJson(this, toJsonT);
}
