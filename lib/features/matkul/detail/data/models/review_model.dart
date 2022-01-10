part of '_models.dart';

// class ReviewModel {
//   ReviewModel({
//     this.author,
//     this.matkul,
//     this.description,
//     this.likesCount,
//     this.classTakenOn,
//     this.reviewedOn,
//     this.status,
//     this.id,
//   });
//
//   ReviewModel.fromJson(Map<String, dynamic> json) {
//     author = json['author'];
//     matkul = json['matkul'];
//     likesCount = json['likesCount'];
//     classTakenOn = json['classTakenOn'];
//     id = json['id'];
//   }
//
//   String? author;
//   String? matkul;
//   String? description;
//   int? likesCount;
//   String? classTakenOn;
//   DateTime? reviewedOn;
//   String? status;
//   int? id;
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['author'] = author;
//     data['matkul'] = matkul;
//     data['description'] = description;
//     data['likesCount'] = likesCount;
//     data['classTakenOn'] = classTakenOn;
//     data['reviewedOn'] = reviewedOn;
//     data['status'] = status;
//     data['id'] = id;
//     return data;
//   }
//
//   bool isEmpty() {
//     return author == null;
//   }
//
//   @override
//   bool operator ==(Object other) {
//     if (other is ReviewModel) {
//       return author == other.author &&
//           matkul == other.matkul &&
//           description == other.description &&
//           classTakenOn == other.classTakenOn &&
//           reviewedOn == other.reviewedOn;
//     }
//     return super == other;
//   }
//
//   @override
//   int get hashCode => super.hashCode;
// }
