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
    focusNode.addListener(() {
      final controller = searchMatkul.state.controller;
      if (controller.text.isNotEmpty && !focusNode.hasFocus) {
        searchMatkul.setState((s) => s.addToHistory(controller.text));
      }
    });
  }

  @override
  Future<void> retrieveData() async {
    await searchMatkul.setState((s) => s.retrieveData(QuerySearch()));
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
                  controller: searchMatkul.state.controller,
                  onClear: () {
                    focusNode.unfocus();
                    searchMatkul.state.controller.clear();
                  },
                  onFieldSubmitted: (val) {
                    searchMatkul.state.addToHistory(val);
                  },
                  onChange: onQueryChanged,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: OnReactive(() {
            if (focusNode.hasFocus &&
                searchMatkul.state.controller.text.isEmpty) {
              return _buildHistory();
            } else {
              return SearchListView(
                refreshIndicatorKey: refreshIndicatorKey,
                scrollController: scrollController,
                onScroll: onScroll,
                onRefresh: retrieveData,
              );
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
    final query = QuerySearch(q: searchMatkul.state.controller.text);
    searchMatkul.state.retrieveMoreData(query).then((value) {
      completer = Completer<void>();
      searchMatkul.notify();
    }).onError((error, stackTrace) {
      completer = Completer<void>();
    });
  }

  @override
  bool scrollCondition() {
    return !searchMatkul.state.hasReachedMax;
  }

  /// Every Query changed do debouncing and rebuild.
  Future<void> onQueryChanged(String val) async {
    if (val == searchMatkul.state.lastQuery) {
      return;
    }
    searchMatkul.state.lastQuery = val;
    searchMatkul.notify();
    if (_debounce == null || !(_debounce?.isActive ?? true)) {
      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      }
      await searchMatkul.setState((s) {
        s.hasReachedMax = false;
      });
      _debounce = Timer(const Duration(milliseconds: 2000), () {
        final query = QuerySearch(q: searchMatkul.state.controller.text);
        searchMatkul.state
            .searchMatkul(query)
            .then((value) => searchMatkul.notify());
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
                    searchMatkul.setState((s) => s.clearHistory());
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
              children: searchMatkul.state.history.map((element) {
                return InkWell(
                  onTap: () {
                    final controller = searchMatkul.state.controller;
                    focusNode.requestFocus();
                    controller
                      ..text = element
                      ..selection = TextSelection.fromPosition(TextPosition(
                          offset: searchMatkul.state.controller.text.length));
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
}
