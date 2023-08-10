// Created by Muhamad Fauzi Ridwan on 08/11/21.

part of '_widgets.dart';

class BaseAppBar extends AppBar {
  BaseAppBar({
    super.key,
    Function()? onBackPress,
    String? label,
    super.actions,
    bool hasLeading = true,
    bool super.centerTitle = true,
    double? elevation,
    Color? color,
  }) : super(
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
          title: Text(
            label.toString(),
            style: FontTheme.poppins14w700black(),
          ),
        );
}
