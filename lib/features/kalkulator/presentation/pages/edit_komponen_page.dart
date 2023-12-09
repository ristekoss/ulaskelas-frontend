part of '_pages.dart';

class EditComponentPage extends StatefulWidget {
  const EditComponentPage({
    required this.id,
    required this.calculatorId,
    required this.courseName,
    required this.totalScore,
    required this.totalPercentage,
    required this.componentName,
    required this.componentScore,
    required this.componentWeight,
    super.key,
  });

  final int id;
  final int calculatorId;
  final String courseName;
  final double totalScore;
  final double totalPercentage;
  final String componentName;
  final double componentScore;
  final double componentWeight;

  @override
  _EditComponentPageState createState() => _EditComponentPageState();
}

class _EditComponentPageState extends BaseStateful<EditComponentPage> {
  @override
  void init() {
    componentFormRM.state.nameController.text = widget.componentName;
    componentFormRM.state.scoreController.text =
        widget.componentScore.toString();
    componentFormRM.state.weightController.text =
        widget.componentWeight.toString();
  }

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
        Center(
          child: InkWell(
            onTap: () {
              nav.pop();
              componentRM.setState(
                (s) => s.deleteComponent(
                  QueryComponent(id: widget.id),
                ),
              );
              nav.replaceToComponentPage(
                calculatorId: widget.calculatorId,
                courseName: widget.courseName,
                totalScore: widget.totalScore -
                    (widget.componentScore * widget.componentWeight / 100),
                totalPercentage:
                    widget.totalPercentage - widget.componentWeight,
              );
            },
            child: Text(
              'Hapus Komponen Nilai',
              style: FontTheme.poppins14w500black().copyWith(
                color: BaseColors.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const HeightSpace(30),
        OnReactive(
          () => SimpanButton(
            isLoading: componentFormRM.state.isLoading,
            text: 'Simpan Perubahan',
            onTap: () async {
              await onSubmitCallBack(context);
            },
          ),
        ),
      ],
    );
  }

  Future<void> onSubmitCallBack(BuildContext context) async {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (componentFormRM.state.isLoading) {
      return;
    }
    if (componentFormRM.state.formKey.currentState!.validate()) {
      await componentFormRM.state.submitEditForm(
        widget.id,
        widget.calculatorId,
      );
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

  double _temporaryUpdateScore(
    double newScore,
    double newWeight,
  ) {
    return widget.totalScore -
        (widget.componentScore * widget.componentWeight / 100) +
        (newScore * newWeight / 100);
  }

  double _temporaryUpdateWeight(double newWeight) {
    return widget.totalPercentage - widget.componentWeight + newWeight;
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
