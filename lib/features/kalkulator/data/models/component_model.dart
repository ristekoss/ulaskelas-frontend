class ComponentModel {
  int? id;
  int? calculatorId;
  String? name;
  double? weight;
  double? score;

  ComponentModel(
      {this.id, this.calculatorId, this.name, this.weight, this.score,});

  ComponentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    calculatorId = json['calculator_id'];
    name = json['name'];
    weight = json['weight'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['calculator_id'] = calculatorId;
    data['name'] = name;
    data['weight'] = weight;
    data['score'] = score;
    return data;
  }
}
