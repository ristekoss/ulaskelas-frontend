// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_pages.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({
    Key? key,
  }) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends BaseStateful<FilterPage> {
  final filter = GlobalState.filter();

  @override
  void init() {}

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Filter',
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return StateBuilder(
      observe: GlobalState.filter,
      builder: (context, snapshot) {
        return Stack(
          children: [
            Positioned.fill(
                child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              children: [
                Text(
                  'Jenis Mata Kuliah',
                  style: FontTheme.poppins14w700black(),
                ),
                const HeightSpace(8),
                GridView.count(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 4,
                  children: filter.state.matkulTypes.map((item) {
                    return CheckboxTile(
                      value: filter.state.selectedType.contains(item.value),
                      text: item.text,
                      onChanged: (val) {
                        if (val ?? true) {
                          filter.setState(
                            (s) => s.pickMatkulType(item.value.toString()),
                          );
                        } else {
                          filter.setState(
                            (s) => s.discardMatkulType(item.value.toString()),
                          );
                        }
                        setState(() {});
                      },
                    );
                  }).toList(),
                ),
                const HeightSpace(20),
                Text(
                  'Jumlah SKS',
                  style: FontTheme.poppins14w700black(),
                ),
                const HeightSpace(8),
                GridView.count(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 4,
                  children: filter.state.sksTotals.map((item) {
                    return CheckboxTile(
                      value: filter.state.selectedSks.contains(item.value),
                      text: item.text,
                      onChanged: (val) {
                        if (val ?? true) {
                          filter.setState(
                            (s) => s.pickSksTotal(item.value.toString()),
                          );
                        } else {
                          filter.setState(
                            (s) => s.discardSksTotal(item.value.toString()),
                          );
                        }
                        setState(() {});
                      },
                    );
                  }).toList(),
                ),
                const HeightSpace(20),
                Text(
                  'Semester Wajib Mengambil',
                  style: FontTheme.poppins14w700black(),
                ),
                const HeightSpace(8),
                GridView.count(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 4,
                  children: filter.state.semesterPreconditions.map((item) {
                    return CheckboxTile(
                      value: filter.state.selectedSemester.contains(item.value),
                      text: item.text,
                      onChanged: (val) {
                        if (val ?? true) {
                          filter.setState(
                            (s) => s.pickSemesterPrecondition(
                                item.value.toString()),
                          );
                        } else {
                          filter.setState(
                            (s) => s.discardSemesterPrecondition(
                                item.value.toString()),
                          );
                        }
                        setState(() {});
                      },
                    );
                  }).toList(),
                ),
              ],
            )),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: BaseColors.white,
                  boxShadow: BoxShadowDecorator().defaultShadow(context),
                ),
                child: AutoLayoutButton(
                  text: 'Terapkan Filter',
                  onTap: () {
                    nav.pop<bool>(true);
                  },
                ),
              ),
            )
          ],
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
    return true;
  }
}
