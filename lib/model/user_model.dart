import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String user_name;
  final String user_phone;
  final String user_email;
  final String user_password;
  final String role_name;

  UserModel({
    required this.user_name,
    required this.user_phone,
    required this.user_email,
    required this.user_password,
    required this.role_name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
