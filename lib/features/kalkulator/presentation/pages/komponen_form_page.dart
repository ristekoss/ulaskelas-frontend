part of '_pages.dart';

class ComponentFormPage extends StatefulWidget {
  const ComponentFormPage({
    required this.calculatorId,
    required this.courseName,
    required this.totalScore,
    required this.totalPercentage,
    super.key,
  });

  final int calculatorId;
  final String courseName;
  final double totalScore;
  final double totalPercentage;

  @override
  _ComponentFormPageState createState() => _ComponentFormPageState();
}

class _ComponentFormPageState extends BaseStateful<ComponentFormPage> {
  @override
  void init() {}

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Tambah Komponen',
      onBackPress: onBackPressed,
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return Column(
      children: [
        Expanded(
          child: Form(
            key: componentFormRM.state.formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildNameField(),
                const HeightSpace(20),
                _buildScoreField(),
                const HeightSpace(20),
                _buildWeightField(),
              ],
            ),
          ),
        ),
        OnReactive(
          () => SimpanButton(
            isLoading: componentFormRM.state.isLoading,
            text: 'Simpan',
            onTap: () async {
              await onSubmitCallBack(context);
            },
          ),
        ),
      ],
    );
  }

  double _temporaryUpdateScore(
    double newScore,
    double newWeight,
  ) {
    return widget.totalScore + (newScore * newWeight / 100);
  }

  double _temporaryUpdateWeight(double newWeight) {
    return widget.totalPercentage + newWeight;
  }

  Future<void> onSubmitCallBack(BuildContext context) async {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (componentFormRM.state.isLoading) {
      return;
    }
    MixpanelService.track('calculator_add_course_component');
    if (componentFormRM.state.formKey.currentState!.validate()) {
      // progressDialogue(context);
      await componentFormRM.state.submitForm(widget.calculatorId);
      await Future.delayed(const Duration(milliseconds: 150));
      nav.pop();
      await nav.replaceToComponentPage(
        calculatorId: widget.calculatorId,
        courseName: widget.courseName,
        totalScore: _temporaryUpdateScore(
          componentFormRM.state.formData.score!,
          componentFormRM.state.formData.weight!,
        ),
        totalPercentage: _temporaryUpdateWeight(
          componentFormRM.state.formData.weight!,
        ),
      );
      componentFormRM.state.cleanForm();
      return;
    }
    WarningMessenger('Harap isi semua field').show(context);
  }

  TextFormField _buildNameField() {
    return TextFormField(
      controller: componentFormRM.state.nameController,
      minLines: 1,
      style: FontTheme.poppins12w400black(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        // constraints: const BoxConstraints(maxHeight: 12.5 * 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: 'Nama Komponen',
      ),
      textInputAction: TextInputAction.newline,
      onChanged: (value) {
        if (value.trim().isEmpty) {
          componentFormRM.state.nameController.text = '';
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required.';
        }
        componentFormRM.setState((s) => s.setName());
        return null;
      },
    );
  }

  TextFormField _buildScoreField() {
    return TextFormField(
      controller: componentFormRM.state.scoreController,
      minLines: 1,
      style: FontTheme.poppins12w400black(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[0-9]+[,.]{0,1}[0-9]*')),
      ],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        // constraints: const BoxConstraints(maxHeight: 12.5 * 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: 'Nilai',
      ),
      onChanged: (value) {
        if (value.trim().isEmpty) {
          componentFormRM.state.scoreController.text = '';
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required.';
        }
        componentFormRM.setState((s) => s.setScore());
        return null;
      },
    );
  }

  TextFormField _buildWeightField() {
    return TextFormField(
      controller: componentFormRM.state.weightController,
      minLines: 1,
      style: FontTheme.poppins12w400black(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[0-9]+[,.]{0,1}[0-9]*')),
      ],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        // constraints: const BoxConstraints(maxHeight: 12.5 * 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: 'Bobot (%)',
      ),
      onChanged: (value) {
        if (value.trim().isEmpty) {
          componentFormRM.state.weightController.text = '';
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required.';
        }
        componentFormRM.setState((s) => s.setWeight());
        return null;
      },
    );
  }

  @override
  Widget buildWideLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return buildNarrowLayout(context, sizeInfo);
  }

  @override
  Future<bool> onBackPressed() async {
    componentFormRM.state.cleanForm();
    nav.pop<void>();
    return true;
  }
}
