import 'package:json_annotation/json_annotation.dart';
import 'student_model.dart'; // Assuming this exists

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserModel {
  final int userId;
  final String userName;
  final String userPhone;
  final String userEmail;
  final String roleName;
  final String? fcmToken;
  final String updatedAt;
  final String createdAt;
  final StudentModel? student;

  UserModel({
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.userEmail,
    required this.roleName,
    this.fcmToken,
    required this.updatedAt,
    required this.createdAt,
    this.student,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
