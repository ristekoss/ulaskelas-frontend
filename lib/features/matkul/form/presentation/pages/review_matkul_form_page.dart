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
    return Form(
      key: reviewForm.state.formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            // TODO(;): Semester Drop Down
            // TODO(;): Year Drop Down
            _buildAddTag(),
          ],
        ),
      ),
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
          text: 'Tambah Tag',
        ),
      ],
    );
  }
}
