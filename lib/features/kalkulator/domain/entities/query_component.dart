class QueryComponent {
  int? id;
  int? calculatorId;

  QueryComponent({
    this.calculatorId,
    this.id,
  });

  @override
  String toString() {
    final data = <String, String>{};
    if (calculatorId != null) {
      data['calculator_id'] = calculatorId.toString();
    }
    if (id != null) {
      data['id'] = id.toString();
    }
    return Uri(queryParameters: data).query;
  }
}
