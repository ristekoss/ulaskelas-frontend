import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ulaskelas/core/theme/_theme.dart';

class KeluarButton extends StatelessWidget {
  const KeluarButton(this.handler, {super.key});
  final Function() handler;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: handler,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(width: 2, color: BaseColors.error),
        fixedSize: const Size(1000000, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'Keluar',
        style: GoogleFonts.poppins(
          color: BaseColors.error,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
