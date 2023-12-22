import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:ulaskelas/core/constants/_constants.dart';
import 'package:ulaskelas/core/theme/_theme.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    required this.title, required this.description, super.key,
    this.padTop,
  });

  final String title;
  final String description;
  final double? padTop;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeightSpace(padTop ?? size.height * .1),
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
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const HeightSpace(40),
        ],
      ),
    );
  }
}
