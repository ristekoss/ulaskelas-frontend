part of '_models.dart';

class ReviewModel {
  ReviewModel({
    this.author,
    this.matkul,
    this.likesCount,
    this.classTakenOn,
  });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    matkul = json['matkul'];
    likesCount = json['likesCount'];
    classTakenOn = json['classTakenOn'];
  }

  String? author;
  String? matkul;
  int? likesCount;
  String? classTakenOn;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['author'] = author;
    data['matkul'] = matkul;
    data['likesCount'] = likesCount;
    data['classTakenOn'] = classTakenOn;
    return data;
  }

  bool isEmpty() {
    return author == null;
  }

  @override
  bool operator ==(Object other) {
    if (other is ReviewModel) {
      return author == other.author &&
          matkul == other.matkul &&
          classTakenOn == other.classTakenOn;
    }
    return super == other;
  }

  @override
  int get hashCode => super.hashCode;
}
