part of '_states.dart';

class ComponentFormState {
  ComponentFormState() {
    final remoteDataSource = ComponentRemoteDataSourceImpl();
    _repo = ComponentRepositoryImpl(
      remoteDataSource,
    );
  }

  late ComponentRepository _repo;
  final formKey = GlobalKey<FormState>();
  var _formData = ComponentData();
  final _nameController = TextEditingController();
  final _scoreController = TextEditingController();
  final _weightController = TextEditingController();

  bool isLoading = false;

  /// Submitting form data
  Future<void> submitForm(int calculatorId) async {
    isLoading = true;
    componentFormRM.notify();
    final result = <String, dynamic>{};

    result['calculator_id'] = calculatorId;
    result['name'] = _formData.name;
    result['score'] = _formData.score;
    result['weight'] = _formData.weight;

    final resp = await _repo.createComponent(result);
    isLoading = false;
    componentFormRM.notify();
    resp.fold((failure) {
      throw failure;
    }, (result) {
      final successSubmittedComponent = result.data;
      print(successSubmittedComponent);
    });
  }

  Future<void> submitEditForm(int id, int calculatorId) async {
    isLoading = true;
    componentFormRM.notify();
    final result = <String, dynamic>{};

    result['id'] = id;
    result['calculator_id'] = calculatorId;
    result['name'] = _formData.name;
    result['score'] = _formData.score;
    result['weight'] = _formData.weight;

    final resp = await _repo.editComponent(result);
    isLoading = false;
    componentFormRM.notify();
    resp.fold((failure) {
      throw failure;
    }, (result) {
      final successEditedComponent = result.data;
      print(successEditedComponent);
    });
  }

  ComponentData get formData => _formData;

  TextEditingController get nameController => _nameController;
  TextEditingController get scoreController => _scoreController;
  TextEditingController get weightController => _weightController;

  void setName() {
    _formData.name = nameController.text;
  }

  void setScore() {
    _formData.score = double.parse(scoreController.text);
  }

  void setWeight() {
    _formData.weight = double.parse(weightController.text);
  }

  /// Cleaning form when success submitting form
  void cleanForm() {
    _formData = ComponentData();
    _nameController.text = '';
    _scoreController.text = '';
    _weightController.text = '';
  }
}

class ComponentData {

  String? name;
  double? score;
  double? weight;
}
