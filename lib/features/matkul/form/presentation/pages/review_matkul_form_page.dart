// Created by Muhamad Fauzi Ridwan on 20/11/21.

part of '_pages.dart';

class ReviewMatkulFormPage extends StatefulWidget {
  const ReviewMatkulFormPage({
    required this.course, super.key,
  });

  final CourseModel course;

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
            key: reviewFormRM.state.formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  widget.course.name.toString(),
                  style: FontTheme.poppins20w700black(),
                ),
                const HeightSpace(8),
                Text(
                  widget.course.describe,
                  style: FontTheme.poppins14w400black(),
                ),
                const HeightSpace(24),
                _buildSemesterDropDown(),
                const HeightSpace(24),
                _buildYearDropDown(),
                const HeightSpace(24),
                const GuidelineCard(),
                const HeightSpace(24),
                _buildDescField(),
                const HeightSpace(24),
                _buildAddRating(),
                const HeightSpace(24),
                _buildAddTag(),
                const HeightSpace(24),
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gunakan anonim',
                            style: FontTheme.poppins12w400black()
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Unggah ulasanmu secara anonim agar '
                            'namamu tidak terlihat oleh orang lain.',
                            style: FontTheme.poppins10w400black(),
                          ),
                        ],
                      ),
                    ),
                    OnReactive(() {
                      return FlutterSwitch(
                        width: 46,
                        height: 24,
                        toggleSize: 20,
                        borderRadius: 32,
                        padding: 0,
                        value: reviewFormRM.state.formData.isAnonymous,
                        activeColor: BaseColors.purpleHearth.withOpacity(0.8),
                        inactiveColor: BaseColors.gray5,
                        switchBorder: Border.all(
                          color: BaseColors.gray4,
                        ),
                        toggleBorder: Border.all(
                          color: BaseColors.gray1.withOpacity(0.20),
                        ),
                        onToggle: (val) {
                          reviewFormRM.setState((s) => s.setAnon(val: val));
                        },
                      );
                    }),
                  ],
                ),
                OnReactive(
                  () => TulisUlasanButton(
                    text: 'Kirim Ulasan',
                    isLoading: reviewFormRM.state.isLoading,
                    onTap: () async {
                      final currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      if (reviewFormRM.state.isLoading) {
                        return;
                      }

                      final reviewFormState = reviewFormRM.state;
                      final reviewFormStateData = reviewFormState.formData;
                      if (reviewFormState.formKey.currentState!.validate() &&
                          reviewFormStateData.ratingUnderstandable != null &&
                          reviewFormStateData.ratingFitToCredit != null &&
                          reviewFormStateData.ratingFitToStudyBook != null &&
                          reviewFormStateData.ratingBeneficial != null &&
                          reviewFormStateData.ratingRecommended != null) {
                        await reviewFormRM.state
                            .submitForm(widget.course.code!);
                        await Future.delayed(const Duration(milliseconds: 150));
                        reviewFormRM.state.cleanForm();
                        nav.pop();
                        await nav.replaceToReviewPendingPage();
                        return;
                      }
                      WarningMessenger('Harap isi semua field').show(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
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
          reviewFormRM.state.descController.text = '';
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required.';
        }
        if (value.length < 6) {
          return 'This field is too short';
        }
        reviewFormRM.setState((s) => s.setDesc());
        return null;
      },
    );
  }

  Widget _buildYearDropDown() {
    return FormField<String>(
      initialValue: reviewFormRM.state.formData.year,
      validator: (value) {
        if (value == null) {
          return 'This field is required.';
        }
        return null;
      },
      builder: (field) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: BaseColors.gray3),
          ),
          child: OnReactive(
            () {
              return DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text(
                    'Tahun mengambil',
                    style: FontTheme.poppins12w400black2(),
                  ),
                  isExpanded: true,
                  value: field.value,
                  onChanged: (value) async {
                    await reviewFormRM.setState((s) => s.setYear(value!));
                    field.didChange(value);
                  },
                  onTap: () {
                    final currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  items: reviewFormRM.state.years
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(
                            e,
                            style: FontTheme.poppins12w400black(),
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSemesterDropDown() {
    return FormField<String>(
      initialValue: reviewFormRM.state.formData.semester,
      validator: (value) {
        if (value == null) {
          return 'This field is required.';
        }
        return null;
      },
      builder: (field) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: BaseColors.gray3),
          ),
          child: OnReactive(() {
            return DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text(
                  'Periode mengambil',
                  style: FontTheme.poppins12w400black2(),
                ),
                isExpanded: true,
                value: field.value,
                onChanged: (value) async {
                  await reviewFormRM.setState((s) => s.setSemester(value!));
                  field.didChange(value);
                },
                onTap: () {
                  final currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                items: reviewFormRM.state.semesters
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(
                          e,
                          style: FontTheme.poppins12w400black(),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }),
        );
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

  Widget _buildAddTag() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Tag Mata Kuliah (opsional)',
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
            children: reviewFormRM.state.formData.tagData.map((element) {
              return Tag(
                label: element,
              );
            }).toList(),
          );
        }),
        const HeightSpace(10),
        SecondaryButton(
          width: double.infinity,
          onPressed: () async {
            final result = await nav.goToAddReviewMatkulTagPage();
            Logger().w(result);
            if (result != null) {
              await reviewFormRM.setState((s) {
                s.selectTag = result;
                return;
              });
            }
          },
          child: Center(
            child: Text(
              'Tambah Tag',
              style: FontTheme.poppins14w600black()
                  .copyWith(color: BaseColors.purpleHearth),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Berikan Penilaian',
          style: FontTheme.poppins14w700black(),
        ),
        const HeightSpace(8),
        SizedBox(
          height: 115,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            clipBehavior: Clip.none,
            children: <Widget>[
              //your widget items here
              RatingComponent(
                text: 'Saya dapat dengan mudah memahami mata kuliah',
                starRating: StarRating(
                  rating: reviewFormRM.state.formData.ratingUnderstandable ?? 0,
                  starSize: 30,
                  onRatingChanged: (newRating) => setState(
                    () {
                      reviewFormRM.setState(
                        (s) => s.setRatingUnderstandable(
                          ratingUnderstandable: newRating,
                        ),
                      );
                    },
                  ),
                ),
              ),
              RatingComponent(
                text: 'Pelaksanaan mata kuliah sesuai dengan SKS',
                starRating: StarRating(
                  rating: reviewFormRM.state.formData.ratingFitToCredit ?? 0,
                  starSize: 30,
                  onRatingChanged: (newRating) => setState(
                    () {
                      reviewFormRM.setState(
                        (s) => s.setRatingFitToCredit(
                          ratingFitToCredit: newRating,
                        ),
                      );
                    },
                  ),
                ),
              ),
              RatingComponent(
                text: 'Pelaksanaan mata kuliah sesuai dengan BRP',
                starRating: StarRating(
                  rating: reviewFormRM.state.formData.ratingFitToStudyBook ?? 0,
                  starSize: 30,
                  onRatingChanged: (newRating) => setState(
                    () {
                      reviewFormRM.setState(
                        (s) => s.setRatingFitToStudyBook(
                          ratingFitToStudyBook: newRating,
                        ),
                      );
                    },
                  ),
                ),
              ),
              RatingComponent(
                text: 'Saya mendapat banyak manfaat dari mata kuliah',
                starRating: StarRating(
                  rating: reviewFormRM.state.formData.ratingBeneficial ?? 0,
                  starSize: 30,
                  onRatingChanged: (newRating) => setState(
                    () {
                      reviewFormRM.setState(
                        (s) => s.setRatingBeneficial(
                          ratingBeneficial: newRating,
                        ),
                      );
                    },
                  ),
                ),
              ),
              RatingComponent(
                text: 'Saya merekomendasikan pengambilan mata kuliah',
                starRating: StarRating(
                  rating: reviewFormRM.state.formData.ratingRecommended ?? 0,
                  starSize: 30,
                  onRatingChanged: (newRating) => setState(
                    () {
                      reviewFormRM.setState(
                        (s) => s.setRatingRecommended(
                          ratingRecommended: newRating,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const HeightSpace(10),
      ],
    );
  }
}
