// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_pages.dart';

class SearchCoursePage extends StatefulWidget {
  const SearchCoursePage({
    super.key,
  });

  @override
  _SearchCoursePageState createState() => _SearchCoursePageState();
}

class _SearchCoursePageState
    extends BasePaginationState<SearchCoursePage, SearchCourseState> {
  final focusNode = FocusNode();

  Timer? _debounce;

  @override
  void init() {
    focusNode.addListener(() {
      final controller = searchCourseRM.state.controller;
      if (controller.text.isNotEmpty && !focusNode.hasFocus) {
        searchCourseRM.setState((s) => s.addToHistory(controller.text));
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Future<void> retrieveData() async {
    await searchCourseRM.setState(
      (s) => s.retrieveData(
        QuerySearchCourse(
          name: searchCourseRM.state.controller.text,
        ),
      ),
    );
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
    ReactiveModel<SearchCourseState> k,
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
                  controller: searchCourseRM.state.controller,
                  onClear: () {
                    focusNode.unfocus();
                    searchCourseRM.state.controller.clear();
                  },
                  onFieldSubmitted: (val) =>
                      searchCourseRM.state.addToHistory(val),
                  onChange: onQueryChanged,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: OnReactive(() {
            if (focusNode.hasFocus &&
                searchCourseRM.state.controller.text.isEmpty) {
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
    ReactiveModel<SearchCourseState> k,
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
    final query = QuerySearchCourse(
      name: searchCourseRM.state.controller.text,
    );
    searchCourseRM.state.retrieveMoreData(query).then((value) {
      completer = Completer<void>();
      searchCourseRM.notify();
    }).onError((error, stackTrace) {
      completer = Completer<void>();
    });
  }

  @override
  bool scrollCondition() {
    return !searchCourseRM.state.hasReachedMax;
  }

  /// Every Query changed do debouncing and rebuild.
  Future<void> onQueryChanged(String val) async {
    if (val == searchCourseRM.state.lastQuery) {
      return;
    }
    searchCourseRM.state.lastQuery = val;
    searchCourseRM.notify();

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    await searchCourseRM.setState((s) {
      s.hasReachedMax = false;
      return;
    });
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      final query = QuerySearchCourse(name: val);
      // final query = QuerySearchCourse();
      searchCourseRM.state
          .searchMatkul(query)
          .then((value) => searchCourseRM.notify());
    });
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
                    searchCourseRM.setState((s) => s.clearHistory());
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
            children: searchCourseRM.state.history.map((element) {
              return InkWell(
                onTap: () {
                  final controller = searchCourseRM.state.controller;
                  focusNode.requestFocus();
                  controller
                    ..text = element
                    ..selection = TextSelection.fromPosition(
                      TextPosition(
                        offset: searchCourseRM.state.controller.text.length,
                      ),
                    );
                  onQueryChanged(element);
                },
                child: Tag(
                  label: element,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  bool enable = true;
}
