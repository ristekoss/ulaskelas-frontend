class ProfileModel {
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
  int? term;
  String? generation;

  ProfileModel({
    this.id,
    this.username,
    this.name,
    this.npm,
    this.faculty,
    this.studyProgram,
    this.educationalProgram,
    this.role,
    this.orgCode,
    this.isBlocked,
    this.user,
    this.term,
    this.generation,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
    term = json['term'];
    generation = json['generation'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['npm'] = npm;
    data['faculty'] = faculty;
    data['study_program'] = studyProgram;
    data['educational_program'] = educationalProgram;
    data['role'] = role;
    data['org_code'] = orgCode;
    data['is_blocked'] = isBlocked;
    data['user'] = user;
    data['term'] = term;
    data['generation'] = generation;
    return data;
  }
}
