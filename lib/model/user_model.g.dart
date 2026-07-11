// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  userId: (json['user_id'] as num?)?.toInt(),
  userName: json['user_name'] as String,
  userPhone: json['user_phone'] as String,
  userEmail: json['user_email'] as String,
  userPassword: json['user_password'] as String?,
  roleName: json['role_name'] as String,
  fcmToken: json['fcm_token'] as String?,
  updatedAt: json['updated_at'] as String,
  createdAt: json['created_at'] as String,
  student: json['student_academic'] == null
      ? null
      : StudentModel.fromJson(json['student_academic'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'user_id': instance.userId,
  'user_name': instance.userName,
  'user_phone': instance.userPhone,
  'user_email': instance.userEmail,
  'user_password': instance.userPassword,
  'role_name': instance.roleName,
  'fcm_token': instance.fcmToken,
  'updated_at': instance.updatedAt,
  'created_at': instance.createdAt,
  'student_academic': instance.student?.toJson(),
};
