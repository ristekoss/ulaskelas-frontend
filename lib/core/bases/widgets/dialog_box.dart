import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';

abstract class DialogBox {
  const DialogBox();
  Widget buildHeader();
  Widget buildContent();
  Widget buildActions();

  Widget get material => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildHeader(),
              const HeightSpace(15),
              buildContent(),
              const HeightSpace(20),
              buildActions(),
            ],
          ),
        ),
      );

  Widget materialWithChild(Widget child, {double? radius}) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }

  Widget materialWithRadius(double radius, {double? padding}) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        child: Padding(
          padding: EdgeInsets.all(padding ?? 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildHeader(),
              buildContent(),
              buildActions(),
            ],
          ),
        ),
      );

  static Widget get emptyHeader => const AreaSpace(size: 0);
  static Widget get emptyActions => const AreaSpace(size: 0);
}
