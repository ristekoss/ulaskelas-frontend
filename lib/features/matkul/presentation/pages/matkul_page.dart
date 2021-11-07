// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_pages.dart';

class MatkulPage extends StatefulWidget {
  const MatkulPage({
    Key? key,
  }) : super(key: key);

  @override
  _MatkulPageState createState() => _MatkulPageState();
}

class _MatkulPageState extends BaseStateful<MatkulPage> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void init() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      WarningMessenger('message').show(ctx!);
    });
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return null;
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              SearchField(
                hintText: 'Cari mata kuliah',
                focusNode: focusNode,
                controller: controller,
                onClear: () {
                  // TODO(pawpaw): clear search text
                  focusNode.unfocus();
                  controller.clear();
                },
              ),
              const HeightSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Daftar Mata Kuliah',
                    style: FontTheme.poppins14w700black(),
                  ),
                  FilterButton(
                    hasFilter: true,
                    text: 'Filter',
                    onPressed: () {
                      nav.goToFilterPage();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            itemCount: 8,
            separatorBuilder: (c, i) => const HeightSpace(16),
            itemBuilder: (c, i) {
              return CardMatkul(
                model: MatkulModel(
                  reviews: 8,
                  shortName: 'PL',
                  name: 'Kecerdasan Artifisial dan Sains Data Dasar',
                  precondition: 'Wajib SI',
                ),
              );
            },
          ),
        ),
      ],
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
    return true;
  }
}
