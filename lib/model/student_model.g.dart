// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) => StudentModel(
  academicId: (json['academic_id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  studentId: json['student_id'] as String,
  academicYear: json['academic_year'] as String,
  semester: json['semester'] as String,
  yearLevel: json['year_level'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      'academic_id': instance.academicId,
      'user_id': instance.userId,
      'student_id': instance.studentId,
      'academic_year': instance.academicYear,
      'semester': instance.semester,
      'year_level': instance.yearLevel,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
