// Created by Muhamad Fauzi Ridwan on 27/12/21.

part of '_widgets.dart';

class SearchListView extends StatelessWidget {
  const SearchListView({
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
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Daftar Mata Kuliah',
                  style: FontTheme.poppins14w700black(),
                ),
                StateBuilder(
                  observe: () => filter,
                  builder: (context, snapshot) {
                    return FilterButton(
                      hasFilter: filter.state.hasFilter,
                      text: 'Filter',
                      onPressed: () async {
                        await nav.goToFilterPage();
                        if (filter.state.hasFilter) {
                          onScroll();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: onRefresh,
            child: OnBuilder<SearchMatkulState>.all(
              listenTo: searchMatkul,
              onIdle: () => WaitingView(),
              onWaiting: () => WaitingView(),
              onError: (dynamic error, refresh) {
                final failure = error as Failure;
                return DetailView(
                  title: failure.title ?? 'Error',
                  description: failure.message ?? 'Something error',
                );
              },
              onData: (data) {
                final matkuls = data.filteredMatkuls;
                if (data.hasReachedMax && matkuls.isEmpty) {
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
                      data.hasReachedMax ? matkuls.length : matkuls.length + 1,
                  separatorBuilder: (c, i) => const HeightSpace(16),
                  itemBuilder: (c, i) {
                    if (!data.hasReachedMax && i == matkuls.length) {
                      return const CircleLoading(size: 25);
                    }
                    final matkul = matkuls[i];
                    return CardMatkul(
                      model: matkul,
                      onTap: () => nav.goToDetailMatkulPage(matkul.name!),
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
