import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:ulaskelas/core/constants/_constants.dart';
import 'package:ulaskelas/core/theme/_theme.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    Key? key,
    required this.title,
    required this.description,
    this.padTop,
  }) : super(key: key);

  final String title;
  final String description;
  final double? padTop;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _padTop = padTop ?? size.height * .1;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeightSpace(_padTop),
          Image.asset(
            Ilustration.notfound,
            width: size.width * .6,
          ),
          const HeightSpace(20),
          Text(
            title,
            style: FontTheme.poppins14w700black().copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const HeightSpace(10),
          Text(
            description,
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
          const HeightSpace(40),
        ],
      ),
    );
  }
}
