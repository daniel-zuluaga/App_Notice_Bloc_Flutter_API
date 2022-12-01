import 'package:app_notice_bloc_flutter/src/model/article.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse{

  late final String status;
  late final String? code;
  late final String? message;
  late final List<Article> articles;

  ApiResponse();

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

}
