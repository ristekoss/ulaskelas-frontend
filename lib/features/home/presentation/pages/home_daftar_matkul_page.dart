part of '_pages.dart';

class HomeCourseListPage extends StatefulWidget {
  const HomeCourseListPage({
    Key? key,
  }) : super(key: key);

  @override
  _HomeCourseListPageState createState() => _HomeCourseListPageState();
}

class _HomeCourseListPageState extends BaseStateful<HomeCourseListPage> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Mata Kuliah Semester ${profileRM.state.profile.term}',
      elevation: 0,
    );
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  Widget buildNarrowLayout(BuildContext context, SizingInformation sizeInfo) {
    return SingleChildScrollView(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        itemCount: currentTermCourseRM.state.courses.length,
        separatorBuilder: (c, i) => const HeightSpace(16),
        itemBuilder: (c, i) {
          final course = currentTermCourseRM.state.courses[i];
          return CardCourse(
            model: course,
            onTap: () {
              nav.goToDetailMatkulPage(
                course.id!,
                course.code!,
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildWideLayout(BuildContext context, SizingInformation sizeInfo) {
    return buildNarrowLayout(context, sizeInfo);
  }

  @override
  void init() {}

  @override
  Future<bool> onBackPressed() async {
    return true;
  }
}
