part of '_widgets.dart';

class SearchListViewSimplified extends StatelessWidget {
  const SearchListViewSimplified({
    Key? key,
    required this.refreshIndicatorKey,
    required this.scrollController,
    required this.onScroll,
    required this.onRefresh,
  }) : super(key: key);

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  final ScrollController scrollController;
  final VoidCallback onScroll;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: onRefresh,
            child: OnBuilder<SearchCourseState>.all(
              listenTo: searchCourseRM,
              onIdle: () => ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                children: List.generate(
                  8,
                  (index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: SkeletonCardCourse(),
                  ),
                ),
              ),
              onWaiting: () => ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                children: List.generate(
                  8,
                  (index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: SkeletonCardCourse(),
                  ),
                ),
              ),
              onError: (dynamic error, refresh) {
                final failure = error as Failure;
                return DetailView(
                  title: failure.title ?? 'Error',
                  description: failure.message ?? 'Something error',
                );
              },
              onData: (data) {
                final courses = data.courses;
                if (data.hasReachedMax && courses.isEmpty) {
                  return const DetailView(
                    isEmptyView: true,
                    title: 'Mata Kuliah Tidak Ditemukan',
                    description: '''
Mata kuliah yang kamu cari tidak ada di aplikasi. Silakan coba lagi dengan kata kunci lain.''',
                  );
                }
                return ListView.separated(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemCount:
                      data.hasReachedMax ? courses.length : courses.length + 1,
                  separatorBuilder: (c, i) => const HeightSpace(16),
                  itemBuilder: (c, i) {
                    if (!data.hasReachedMax && i == courses.length) {
                      return const CircleLoading(size: 25);
                    }
                    final course = courses[i];
                    return CardCourseSimplified(
                      model: course,
                      onTap: () {
                        nav.pop();
                        calculatorRM.setState((s) =>
                            s.postCalculator(course.code!),);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
