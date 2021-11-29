// Created by Muhamad Fauzi Ridwan on 20/11/21.

part of '_pages.dart';

class ReviewMatkulFormPage extends StatefulWidget {
  const ReviewMatkulFormPage({
    Key? key,
  }) : super(key: key);

  @override
  _ReviewMatkulFormPageState createState() => _ReviewMatkulFormPageState();
}

class _ReviewMatkulFormPageState extends BaseStateful<ReviewMatkulFormPage> {
  @override
  void init() {}

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Tulis Ulasan',
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
            key: reviewForm.state.formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  'Kecerdasan Artificial dan Sains Data Dasar',
                  style: FontTheme.poppins20w700black(),
                ),
                const HeightSpace(8),
                Text(
                  'CSIE604273  •  4 SKS  •  Wajib SI',
                  style: FontTheme.poppins14w400black(),
                ),
                const HeightSpace(24),

                _buildSemesterDropDown(),
                const HeightSpace(24),

                _buildYearDropDown(),
                const HeightSpace(24),

                _buildAddTag(),
                const HeightSpace(24),

                _buildDescField(),
                //TODO: set-review-as-anonymous Slider
              ],
            ),
          ),
        ),
        TulisUlasanButton(
          onTap: () {},
        )
      ],
    );
  }

  TextFormField _buildDescField() {
    return TextFormField(
      controller: reviewForm.state.descController,
      maxLines: null,
      minLines: 10,
      keyboardType: TextInputType.multiline,
      style: FontTheme.poppins12w400black(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        // constraints: const BoxConstraints(maxHeight: 12.5 * 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: 'Tulis ulasan terhadap mata kuliah ini di sini..',
      ),
      textInputAction: TextInputAction.newline,
      onChanged: (value) {
        if (value.trim().isEmpty) {
          reviewForm.state.descController.text = '';
        }
      },
    );
  }

  Widget _buildYearDropDown() {
    return OnReactive(() {
      return FormField<String>(
        builder: (field) {
          return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: BaseColors.gray3)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text(
                    'Tahun mengambil',
                    style: FontTheme.poppins12w400black2(),
                  ),
                  isExpanded: true,
                  value: reviewForm.state.formData.year,
                  onChanged: (value) async {
                    await reviewForm.setState((s) => s.setYear(value!));
                  },
                  onTap: () {
                    final currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  items: reviewForm.state.years
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              e,
                              style: FontTheme.poppins12w400black(),
                            ),
                          ))
                      .toList(),
                ),
              ));
        },
      );
    });
  }

  Widget _buildSemesterDropDown() {
    return OnReactive(() {
      return FormField<String>(
        initialValue: reviewForm.state.formData.semester,
        builder: (field) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: BaseColors.gray3)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text(
                  'Periode mengambil',
                  style: FontTheme.poppins12w400black2(),
                ),
                isExpanded: true,
                value: reviewForm.state.formData.semester,
                onChanged: (value) async {
                  await reviewForm.setState((s) => s.setSemester(value!));
                },
                onTap: () {
                  final currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                items: reviewForm.state.semesters
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(
                            e,
                            style: FontTheme.poppins12w400black(),
                          ),
                        ))
                    .toList(),
              ),
            ),
          );
        },
      );
    });
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
    reviewForm.state.cleanForm();
    nav.pop<void>();
    return true;
  }

  Widget _buildAddTag() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Tag Mata Kuliah',
          style: FontTheme.poppins14w700black(),
        ),
        const HeightSpace(8),
        Text(
          '''
Pilih 3 kategori yang menurutmu dapat merepresentasikan mata kuliah ini''',
          style: FontTheme.poppins12w400black(),
        ),
        OnReactive(() {
          return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: reviewForm.state.formData.tagData.map((element) {
                return Tag(
                  label: element.name,
                );
              }).toList());
        }),
        const HeightSpace(10),
        SecondaryButton(
          width: double.infinity,
          onPressed: () async {
            final result = await nav.goToAddReviewMatkulTagPage();
            Logger().w(result);
            if (result != null) {
              await reviewForm.setState((s) {
                s.selectTag = result;
              });
            }
          },
          child: Center(
              child: Text(
            'Tambah Tag',
            style: FontTheme.poppins14w600black()
                .copyWith(color: BaseColors.purpleHearth),
          )),
        ),
      ],
    );
  }
}
