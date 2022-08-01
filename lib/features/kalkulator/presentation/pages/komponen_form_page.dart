part of '_pages.dart';

class ComponentFormPage extends StatefulWidget {
  const ComponentFormPage({
    Key? key,
    required this.calculatorId,
  }) : super(key: key);

 final int calculatorId;

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
            key: reviewFormRM.state.formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildDescField(),
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
            isLoading: reviewFormRM.state.isLoading,
            onTap: () async {
              // final currentFocus = FocusScope.of(context);
              //
              // if (!currentFocus.hasPrimaryFocus) {
              //   currentFocus.unfocus();
              // }
              // if (reviewFormRM.state.isLoading) {
              //   return;
              // }
              // if (reviewFormRM.state.formKey.currentState!.validate()) {
              //   // progressDialogue(context);
              //   await reviewFormRM.state.submitForm(widget.calculatorId);
              //   await Future.delayed(const Duration(milliseconds: 150));
              //   reviewFormRM.state.cleanForm();
              //   nav.pop();
              //   await nav.replaceToReviewPendingPage();
              //   return;
              // }
              // WarningMessenger('Harap isi semua field').show(context);
            },
          ),
        )
      ],
    );
  }

  void progressDialogue(BuildContext context) {
    //set up the AlertDialog
    final alert = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(),
      ),
    );
    showDialog(
      //prevent outside touch
      barrierDismissible: false,
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: alert,
        );
      },
    );
  }

  TextFormField _buildDescField() {
    return TextFormField(
      controller: reviewFormRM.state.descController,
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
          reviewFormRM.state.descController.text = '';
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required.';
        }
        reviewFormRM.setState((s) => s.setDesc());
        return null;
      },
    );
  }

  TextFormField _buildScoreField() {
    return TextFormField(
      controller: reviewFormRM.state.descController,
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
          reviewFormRM.state.descController.text = '';
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required.';
        }
        reviewFormRM.setState((s) => s.setDesc());
        return null;
      },
    );
  }

  TextFormField _buildWeightField() {
    return TextFormField(
      controller: reviewFormRM.state.descController,
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
          reviewFormRM.state.descController.text = '';
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required.';
        }
        reviewFormRM.setState((s) => s.setDesc());
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
    reviewFormRM.state.cleanForm();
    nav.pop<void>();
    return true;
  }

}
