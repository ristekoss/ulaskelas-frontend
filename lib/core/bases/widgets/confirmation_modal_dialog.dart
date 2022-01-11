import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:ulaskelas/core/bases/states/_states.dart';
import 'package:ulaskelas/core/bases/widgets/dialog_box.dart';
import 'package:ulaskelas/core/bases/widgets/svg_image.dart';
import 'package:ulaskelas/core/theme/_theme.dart';

enum ConfirmationModalDialogType {
  info,
  warning,
}

class ConfirmationModalDialog extends DialogBox {
  const ConfirmationModalDialog({
    required this.title,
    required this.description,
    required this.yesLabel,
    required this.noLabel,
    this.type = ConfirmationModalDialogType.info,
  });

  final String title;
  final String description;
  final String yesLabel;
  final String noLabel;
  final ConfirmationModalDialogType type;

  @override
  Widget buildActions({
    VoidCallback? cancelAction,
    VoidCallback? confirmAction,
    Function()? additionalFunction,
    bool confirmEnable = true,
  }) {
    var isLoading = false;
    return StatefulBuilder(
      builder: (context, setState) {
        final theme = Theme.of(context);
        return Row(
          children: [
            Expanded(
              child: Container(
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE3E4E5)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: cancelAction ?? () => nav.pop(false),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          noLabel,
                          style: theme.textTheme.button?.copyWith(
                            color: BaseColors.mineShaft,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const WidthSpace(10),
            Expanded(
              child: PrimaryButton(
                height: 42,
                text: yesLabel,
                onPressed: confirmAction ??
                    (additionalFunction != null
                        ? () async {
                            if (isLoading) {
                              return;
                            }
                            setState(() => isLoading = true);
                            await additionalFunction.call();
                          }
                        : () => nav.pop(true)),
                backgroundColor: type == ConfirmationModalDialogType.warning
                    ? BaseColors.danger
                    : BaseColors.primaryColor,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildContent() {
    return Text(
      description,
      style: FontTheme.rubik16w400neutral(),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget buildHeader() {
    return Column(
      children: [
        GlobalIcon.svg(
          _mapAsset(type),
          height: 96,
          width: 96,
        ),
      ],
    );
  }

  String _mapAsset(ConfirmationModalDialogType type) {
    if (type == ConfirmationModalDialogType.info) {
      return 'info';
    } else if (type == ConfirmationModalDialogType.warning) {
      return 'warning';
    }
    return '';
  }

  Future<bool?> show() async {
    return showDialog<bool>(
      context: nav.navigatorKey.currentContext!,
      builder: (_) => materialWithChild(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildHeader(),
            const HeightSpace(15),
            buildContent(),
            const HeightSpace(20),
            buildActions(),
          ],
        ),
        radius: 16,
      ),
    );
  }
}
