import 'package:json_annotation/json_annotation.dart';
import 'user_model.dart';

part 'register_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class RegisterModel {
  final bool success;
  final String message;
  final String token;
  final UserModel user;

  RegisterModel({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  // Fixed the lowercase 'm' to uppercase 'M' here:
  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  // Fixed the lowercase 'm' to uppercase 'M' here:
  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}
