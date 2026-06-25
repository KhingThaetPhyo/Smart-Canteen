// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  user_name: json['user_name'] as String,
  user_phone: json['user_phone'] as String,
  user_email: json['user_email'] as String,
  user_password: json['user_password'] as String,
  role_name: json['role_name'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'user_name': instance.user_name,
  'user_phone': instance.user_phone,
  'user_email': instance.user_email,
  'user_password': instance.user_password,
  'role_name': instance.role_name,
};
