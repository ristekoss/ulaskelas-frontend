// Created by Muhamad Fauzi Ridwan on 08/11/21.

part of '_widgets.dart';

class BaseAppBar extends AppBar {
  BaseAppBar({
    Key? key,
    Function()? onBackPress,
    String? label,
    List<Widget>? actions,
    bool hasLeading = true,
    bool centerTitle = true,
    double? elevation,
    Color? color,
  }) : super(
          key: key,
          elevation: elevation ?? 1,
          shadowColor: Colors.grey[300],
          backgroundColor: color ?? BaseColors.white,
          foregroundColor: color ?? BaseColors.white,
          automaticallyImplyLeading: false,
          leading: hasLeading
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: onBackPress ?? () => nav.pop<void>(),
                )
              : null,
          centerTitle: centerTitle,
          title: Text(
            label.toString(),
            style: FontTheme.poppins14w700black(),
          ),
          actions: actions,
        );
}
