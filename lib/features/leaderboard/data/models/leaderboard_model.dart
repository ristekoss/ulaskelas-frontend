class LeaderboardModel {
  LeaderboardModel({
    required this.id,
    required this.user,
    required this.username,
    required this.name,
    required this.npm,
    required this.faculty,
    required this.studyProgram,
    required this.educationalProgram,
    required this.role,
    required this.orgCode,
    required this.isBlocked,
    required this.likesCount,
    required this.term,
    required this.generation,
  });

  int id;
  int user;
  String username;
  String name;
  String npm;
  String faculty;
  String studyProgram;
  String educationalProgram;
  String role;
  String orgCode;
  bool isBlocked;
  int likesCount;
  int term;
  String generation;

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) => LeaderboardModel(
    id: json["id"],
    user: json["user"],
    username: json["username"],
    name: json["name"],
    npm: json["npm"],
    faculty: json["faculty"],
    studyProgram: json["study_program"],
    educationalProgram: json["educational_program"],
    role: json["role"],
    orgCode: json["org_code"],
    isBlocked: json["is_blocked"],
    likesCount: json["likes_count"],
    term: json["term"],
    generation: json["generation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "username": username,
    "name": name,
    "npm": npm,
    "faculty": faculty,
    "study_program": studyProgram,
    "educational_program": educationalProgram,
    "role": role,
    "org_code": orgCode,
    "is_blocked": isBlocked,
    "likes_count": likesCount,
    "term": term,
    "generation": generation,
  };
}
