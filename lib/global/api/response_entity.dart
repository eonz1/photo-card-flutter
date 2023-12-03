import 'package:json_annotation/json_annotation.dart';

part 'response_entity.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseEntity<T> {
  String? status;
  T? data;
  String? message;

  ResponseEntity({this.status, this.data, this.message});

  factory ResponseEntity.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ResponseEntityFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ResponseEntityToJson(this, toJsonT);
}
