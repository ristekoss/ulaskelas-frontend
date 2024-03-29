import 'package:flutter/material.dart';
import 'package:ulaskelas/core/theme/_theme.dart';

class ProfileData extends StatelessWidget {
  const ProfileData(this.title, this.data, {Key? key}) : super(key: key);
  final String title, data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 97,
            child: Text(
              title,
              style: FontTheme.poppins12w700black(),
            ),
          ),
          Expanded(
            child: Text(
              data,
              style: FontTheme.poppins12w400black(),
            ),
          )
        ],
      ),
    );
  }
}
