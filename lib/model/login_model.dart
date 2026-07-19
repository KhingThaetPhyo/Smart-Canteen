import 'package:json_annotation/json_annotation.dart';
import 'package:smartcanteen/model/user_model.dart';

part 'login_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class LoginModel {
  final bool success;
  final String message;
  final String? token;
  final UserModel? user;

  LoginModel({
    required this.success,
    required this.message,
    this.token,
    this.user,
  });

  // Fixed the lowercase 'm' to uppercase 'M' here:
  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  // Fixed the lowercase 'm' to uppercase 'M' here:
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
