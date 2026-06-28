import 'package:json_annotation/json_annotation.dart';

part 'student_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class StudentModel {
  final int academicId;
  final int userId;
  final String studentId;
  final String academicYear;
  final String semester;
  final String yearLevel;
  final String createdAt;
  final String updatedAt;

  StudentModel({
    required this.academicId,
    required this.userId,
    required this.studentId,
    required this.academicYear,
    required this.semester,
    required this.yearLevel,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);
}
