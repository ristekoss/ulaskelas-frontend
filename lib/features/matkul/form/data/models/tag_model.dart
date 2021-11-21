part of '_models.dart';

class TagModel {
  TagModel({
    this.id,
    required this.name,
  });

  int? id;
  String name;

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
