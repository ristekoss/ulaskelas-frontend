// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_pages.dart';

class MatkulPage extends StatefulWidget {
  const MatkulPage({
    Key? key,
  }) : super(key: key);

  @override
  _MatkulPageState createState() => _MatkulPageState();
}

class _MatkulPageState
    extends BasePaginationState<MatkulPage, SearchMatkulState> {
  final focusNode = FocusNode();

  Timer? _debounce;

  @override
  void init() {
    search.notify();
    focusNode.addListener(() {
      final controller = search.state.controller;
      if (controller.text.isNotEmpty && !focusNode.hasFocus) {
        search.setState((s) => s.addToHistory(controller.text));
      }
    });
  }

  @override
  Future<void> retrieveData() async {
    await search.setState((s) => s.retrieveData(QuerySearch()));
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
    ReactiveModel<SearchMatkulState> k,
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
              OnReactive(
                () => SearchField(
                  hintText: 'Cari mata kuliah',
                  focusNode: focusNode,
                  controller: search.state.controller,
                  onClear: () {
                    focusNode.unfocus();
                    search.state.controller.clear();
                  },
                  onFieldSubmitted: (val) {
                    search.state.addToHistory(val);
                  },
                  onChange: onQueryChanged,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: OnReactive(() {
            if (focusNode.hasFocus && search.state.controller.text.isEmpty) {
              return _buildHistory();
            } else {
              return _buildSearchList(sizeInfo);
            }
          }),
        ),
      ],
    );
  }

  @override
  Widget buildWideLayout(
    BuildContext context,
    ReactiveModel<SearchMatkulState> k,
    SizingInformation sizeInfo,
  ) {
    return buildNarrowLayout(context, k, sizeInfo);
  }

  @override
  Future<bool> onBackPressed() async {
    focusNode.unfocus();
    return true;
  }

  @override
  void onScroll() {
    completer?.complete();
    final query = QuerySearch();
    search.state.searchMatkul(query).then((value) {
      completer = Completer<void>();
      search.notify();
    }).onError((error, stackTrace) {
      completer = Completer<void>();
    });
  }

  @override
  bool scrollCondition() {
    return !search.state.hasReachedMax;
  }

  /// Every Query changed do debouncing and rebuild
  Future<void> onQueryChanged(String val) async {
    if (val == search.state.lastQuery) {
      return;
    }
    search.state.lastQuery = val;
    search.notify();
    if (_debounce == null || !(_debounce?.isActive ?? true)) {
      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      }
      await search.setState((s) {
        s.hasReachedMax = false;
      });
      _debounce = Timer(const Duration(milliseconds: 2000), () {
        final query = QuerySearch(q: search.state.controller.text);
        search.state.searchMatkul(query).then((value) => search.notify());
      });
    }
  }

  Widget _buildHistory() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Riwayat Pencarian',
                  style: FontTheme.poppins14w700black(),
                ),
                InkWell(
                  onTap: () {
                    search.setState((s) => s.clearHistory());
                  },
                  child: Text(
                    'Hapus',
                    style: FontTheme.poppins12w500black().copyWith(
                      color: BaseColors.error,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const HeightSpace(10),
          Wrap(
              spacing: 10,
              runSpacing: 10,
              children: search.state.history.map((element) {
                return InkWell(
                  onTap: () {
                    final controller = search.state.controller;
                    focusNode.requestFocus();
                    controller
                      ..text = element
                      ..selection = TextSelection.fromPosition(TextPosition(
                          offset: search.state.controller.text.length));
                    onQueryChanged(element);
                  },
                  child: Tag(
                    label: element,
                  ),
                );
              }).toList()),
        ],
      ),
    );
  }

  bool enable = true;

  Widget _buildSearchList(SizingInformation sizeInfo) {
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
            onRefresh: retrieveData,
            child: OnBuilder<SearchMatkulState>.all(
              listenTo: search,
              onIdle: () => WaitingView(),
              onWaiting: () => WaitingView(),
              // onError: (dynamic error) => ErrorView(error: error),
              onError: (dynamic error, refresh) => const Text('error'),
              onData: (data) {
                final query = search.state.controller.text.toLowerCase();
                final matkuls = data.matkuls
                    .where((element) =>
                        (element.name?.toLowerCase().contains(query) ??
                            false) &&
                        (!filter.state.isFilteredType ||
                            filter.state.selectedType
                                .contains(element.matkulTypeValue)))
                    .toList();
                if (data.hasReachedMax && matkuls.isEmpty) {
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemCount:
                      data.hasReachedMax ? matkuls.length : matkuls.length + 1,
                  separatorBuilder: (c, i) => const HeightSpace(16),
                  itemBuilder: (c, i) {
                    if (!data.hasReachedMax && i == matkuls.length) {
                      return const CircleLoading(
                        size: 25,
                      );
                    }
                    final matkul = matkuls[i];
                    return CardMatkul(
                      model: matkul,
                      onTap: () => nav.goToDetailMatkulPage(),
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
