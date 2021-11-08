// Created by Muhamad Fauzi Ridwan on 08/11/21.

part of '_pages.dart';

// TODO(bim): route to review matkul use
/// ```dart
/// nav.push<void>(ReviewMatkulPage, RouteName.reviewMatkul,);
/// ```;
class DetailMatkulPage extends StatefulWidget {
  const DetailMatkulPage({
    Key? key,
  }) : super(key: key);

  @override
  _DetailMatkulPageState createState() => _DetailMatkulPageState();
}

class _DetailMatkulPageState extends BaseStateful<DetailMatkulPage> {
  @override
  void init() {}

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar();
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return Container();
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
