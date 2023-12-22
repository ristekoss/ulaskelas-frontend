// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_pages.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({
    super.key,
  });

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends BaseStateful<FilterPage> {
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
    return OnReactive(
      () {
        return Stack(
          children: [
            Positioned.fromRelativeRect(
              rect: const RelativeRect.fromLTRB(0, 0, 0, 40),
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
                    children: filterRM.state.matkulTypes.map((item) {
                      return CheckboxTile(
                        value: filterRM.state.selectedType.contains(item.value),
                        text: item.text,
                        onChanged: (val) {
                          if (val ?? true) {
                            filterRM.setState(
                              (s) => s.pickMatkulType(item.value.toString()),
                            );
                          } else {
                            filterRM.setState(
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
                    children: filterRM.state.sksTotals.map((item) {
                      return CheckboxTile(
                        value: filterRM.state.selectedSks.contains(item.value),
                        text: item.text,
                        onChanged: (val) {
                          if (val ?? true) {
                            filterRM.setState(
                              (s) => s.pickSksTotal(item.value.toString()),
                            );
                          } else {
                            filterRM.setState(
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
                    children: filterRM.state.semesterPreconditions.map((item) {
                      return CheckboxTile(
                        value: filterRM.state.selectedSemester
                            .contains(item.value),
                        text: item.text,
                        onChanged: (val) {
                          if (val ?? true) {
                            filterRM.setState(
                              (s) => s.pickSemesterPrecondition(
                                item.value.toString(),
                              ),
                            );
                          } else {
                            filterRM.setState(
                              (s) => s.discardSemesterPrecondition(
                                item.value.toString(),
                              ),
                            );
                          }
                          setState(() {});
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
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
                    MixpanelService.track(
                      'apply_course_filter',
                      params: {
                        'jenis_matkul': filterRM.state.selectedType.toString(),
                        'jumlah_sks': filterRM.state.selectedSks.toString(),
                        'semester_wajib_ambil':
                            filterRM.state.selectedSemester.toString(),
                      },
                    );
                  },
                ),
              ),
            ),
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
