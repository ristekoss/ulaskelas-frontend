// Created by Muhamad Fauzi Ridwan on 20/11/21.

part of '_pages.dart';

class AddReviewMatkulTagPage extends StatefulWidget {
  const AddReviewMatkulTagPage({super.key});

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
    final query = QuerySearchTag(
      name: searchTagRM.state.controller.text,
    );
    await searchTagRM.setState((s) => s.retrieveData(query));
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
                      hintText: 'Cari Tag',
                      focusNode: focusNode,
                      controller: searchTagRM.state.controller,
                      onClear: () {
                        focusNode.unfocus();
                        searchTagRM.state.controller.clear();
                        refreshIndicatorKey.currentState?.show();
                      },
                      onChange: onQueryChanged,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: OnReactive(() => _buildSearchList(sizeInfo)),
              // OnReactive(() {
              //   return _buildSearchList(sizeInfo);
              // }),
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
                searchTagRM.state.select();
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
              listenTo: searchTagRM,
              onIdle: WaitingView.new,
              onWaiting: WaitingView.new,
              onError: (dynamic error, refresh) => const Text('error'),
              onData: (data) {
                final matkulTags = data.tags;
                return ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemCount: data.hasReachedMax
                      ? matkulTags.isEmpty
                          ? 1
                          : matkulTags.length
                      : matkulTags.length + 1,
                  separatorBuilder: (c, i) => const HeightSpace(16),
                  itemBuilder: (c, i) {
                    if (matkulTags.isEmpty) {
                      final tag = searchTagRM.state.controller.text;
                      final selectedTags = data.selectedTags;
                      final isSelected = selectedTags.contains(tag);
                      return SelectTag(
                        label: tag,
                        enabled: selectedTags.length < 3 || isSelected,
                        isSelected: isSelected,
                        onChanged: (val) {
                          if (selectedTags.length <= 3) {
                            searchTagRM.setState((s) => s.switchTag(tag));
                          }
                          if (!isSelected) {
                            searchTagRM.setState((s) => s.addNewTag(tag));
                          }
                        },
                      );
                    }
                    if (!data.hasReachedMax && i == matkulTags.length) {
                      return const CircleLoading(
                        size: 25,
                      );
                    }
                    final tag = matkulTags[i];
                    final selectedTags = data.selectedTags;
                    final isSelected = selectedTags.contains(tag);
                    return SelectTag(
                      label: tag,
                      enabled: selectedTags.length < 3 || isSelected,
                      isSelected: isSelected,
                      onChanged: (val) {
                        if (selectedTags.length <= 3) {
                          searchTagRM.setState((s) => s.switchTag(tag));
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
    // searchTagRM.state.cleanSearch();
    nav.pop<void>();
    return true;
  }

  @override
  void onScroll() {
    completer?.complete();
    final query = QuerySearchTag(name: searchTagRM.state.controller.text);
    searchTagRM.state.retrieveMoreData(query).then((value) {
      completer = Completer<void>();
      searchTagRM.notify();
    }).onError((error, stackTrace) {
      completer = Completer<void>();
    });
  }

  @override
  bool scrollCondition() {
    return !searchTagRM.state.hasReachedMax;
  }

  /// Every Query changed do debouncing and rebuild
  Future<void> onQueryChanged(String val) async {
    if (val == searchTagRM.state.lastQuery) {
      return;
    }
    searchTagRM.state.lastQuery = val;
    searchTagRM.notify();

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    await searchTagRM.setState((s) {
      s.hasReachedMax = false;
      return;
    });
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      final query = QuerySearchTag(name: searchTagRM.state.controller.text);
      searchTagRM.state
          .retrieveData(query)
          .then((value) => searchTagRM.notify());
    });
  }
}
