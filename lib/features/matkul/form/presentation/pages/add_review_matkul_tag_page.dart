// Created by Muhamad Fauzi Ridwan on 20/11/21.

part of '_pages.dart';

class AddReviewMatkulTagPage extends StatefulWidget {
  const AddReviewMatkulTagPage({Key? key}) : super(key: key);

  @override
  _AddReviewMatkulTagPageState createState() => _AddReviewMatkulTagPageState();
}

class _AddReviewMatkulTagPageState
    extends BasePaginationState<AddReviewMatkulTagPage, SearchTagState> {
  final focusNode = FocusNode();
  Timer? _debounce;

  @override
  void init() {}

  @override
  Future<void> retrieveData() async {
    await Future.delayed(const Duration(seconds: 1));
    final query = QuerySearch();
    await searchTag.setState((s) => s.retrieveData(query));
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Tambah Tag Mata Kuliah',
      onBackPress: onBackPressed,
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    ReactiveModel<SearchTagState> snapshot,
    SizingInformation sizeInfo,
  ) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: sizeInfo.screenSize.width,
                    child: Text(
                      '''
Pilih maksimal 3 kategori yang menurutmu dapat\nmerepresentasikan mata kuliah ini.''',
                      style: FontTheme.poppins12w700black(),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const HeightSpace(10),
                  OnReactive(
                    () => SearchField(
                      hintText: 'Cari mata kuliah',
                      focusNode: focusNode,
                      controller: searchTag.state.controller,
                      onClear: () {
                        focusNode.unfocus();
                        searchTag.state.controller.clear();
                      },
                      onChange: onQueryChanged,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: OnReactive(() {
                return _buildSearchList(sizeInfo);
              }),
            ),
            const HeightSpace(90),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            color: BaseColors.white,
            child: AutoLayoutButton(
              text: 'Terapkan',
              onTap: () {
                searchTag.state.select();
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget buildWideLayout(
    BuildContext context,
    ReactiveModel<SearchTagState> snapshot,
    SizingInformation sizeInfo,
  ) {
    return buildNarrowLayout(context, snapshot, sizeInfo);
  }

  Widget _buildSearchList(SizingInformation sizeInfo) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: retrieveData,
            child: OnBuilder<SearchTagState>.all(
              listenTo: searchTag,
              onIdle: () => WaitingView(),
              onWaiting: () => WaitingView(),
              // onError: (dynamic error) => ErrorView(error: error),
              onError: (dynamic error, refresh) => const Text('error'),
              onData: (data) {
                final matkulTags = searchTag.state.localSearch();
                if (data.hasReachedMax && matkulTags.isEmpty) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeightSpace(sizeInfo.screenSize.height * .1),
                          Image.asset(
                            Ilustration.notfound,
                            width: sizeInfo.screenSize.width * .6,
                          ),
                          const HeightSpace(20),
                          Text(
                            'Mata Kuliah Tidak Ditemukan',
                            style: FontTheme.poppins14w700black().copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const HeightSpace(10),
                          Text(
                            '''
Mata kuliah yang kamu cari tidak ada di aplikasi. Silakan coba lagi dengan kata kunci lain.''',
                            style: Theme.of(context).textTheme.caption,
                            textAlign: TextAlign.center,
                          ),
                          const HeightSpace(20),
                        ],
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemCount: data.hasReachedMax
                      ? matkulTags.length
                      : matkulTags.length + 1,
                  separatorBuilder: (c, i) => const HeightSpace(16),
                  itemBuilder: (c, i) {
                    if (!data.hasReachedMax && i == matkulTags.length) {
                      return const CircleLoading(
                        size: 25,
                      );
                    }
                    final tag = matkulTags[i];
                    final selectedTags = data.selectedTags;
                    final isSelected = selectedTags.contains(tag);
                    return SelectTag(
                      label: tag.name,
                      enabled: selectedTags.length < 3 || isSelected,
                      isSelected: isSelected,
                      onChanged: (val) {
                        if (selectedTags.length <= 3) {
                          searchTag.setState((s) => s.switchTag(tag));
                        }
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

  @override
  Future<bool> onBackPressed() async {
    searchTag.state.cleanSearch();
    nav.pop<void>();
    return true;
  }

  @override
  void onScroll() {
    completer?.complete();
    final query = QuerySearch();
    searchTag.state.searchTag(query).then((value) {
      completer = Completer<void>();
      searchTag.notify();
    }).onError((error, stackTrace) {
      completer = Completer<void>();
    });
  }

  @override
  bool scrollCondition() {
    return !searchTag.state.hasReachedMax;
  }

  /// Every Query changed do debouncing and rebuild
  Future<void> onQueryChanged(String val) async {
    if (val == searchTag.state.lastQuery) {
      return;
    }
    searchTag.state.lastQuery = val;
    searchTag.notify();
    if (_debounce == null || !(_debounce?.isActive ?? true)) {
      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      }
      await searchTag.setState((s) {
        s.hasReachedMax = false;
      });
      _debounce = Timer(const Duration(milliseconds: 2000), () {
        final query = QuerySearch(q: searchTag.state.controller.text);
        searchTag.state.searchTag(query).then((value) => searchTag.notify());
      });
    }
  }
}
