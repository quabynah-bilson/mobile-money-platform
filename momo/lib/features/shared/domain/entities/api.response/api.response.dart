import 'package:json_annotation/json_annotation.dart';

part 'api.response.g.dart';

@JsonSerializable()
class ApiResponse {
  final bool success;
  final String message;
  final dynamic payload;

  const ApiResponse({
    required this.success,
    required this.message,
    this.payload,
  });

  factory ApiResponse.fromJson(json) => _$ApiResponseFromJson(json);

  @override
  String toString() => _$ApiResponseToJson(this).toString();
}
