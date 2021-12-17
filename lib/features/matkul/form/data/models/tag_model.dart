part of '_models.dart';

class TagModel {
  TagModel({
    this.id,
    required this.name,
  });

  TagModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  int? id;
  late String name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (other is TagModel) {
      return id == other.id;
    }
    return super == other;
  }

  @override
  int get hashCode => super.hashCode;
}
