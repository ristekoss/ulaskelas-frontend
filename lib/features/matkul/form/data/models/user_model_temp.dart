part of '_models.dart';

class UserModelTemp {
  UserModelTemp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    npm = json['npm'];
    faculty = json['faculty'];
    studyProgram = json['study_program'];
    educationalProgram = json['educational_program'];
    role = json['role'];
    orgCode = json['org_code'];
    isBlocked = json['is_blocked'];
    user = json['user'];
  }

  int? id;
  String? username;
  String? name;
  String? npm;
  String? faculty;
  String? studyProgram;
  String? educationalProgram;
  String? role;
  String? orgCode;
  bool? isBlocked;
  int? user;
}
