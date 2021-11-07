// Created by Muhamad Fauzi Ridwan on 01/09/21.

part of '_services.dart';

class DurationService {
  static Duration second() {
    return const Duration(seconds: 1);
  }

  static String formatAsString(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
