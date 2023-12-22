import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ulaskelas/core/theme/_theme.dart';

class SkeletonCardCourse extends StatelessWidget {
  const SkeletonCardCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: BaseColors.white,
        boxShadow: BoxShadowDecorator().defaultShadow(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const WidthSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const HeightSpace(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
