// Created by Muhamad Fauzi Ridwan on 11/08/21.

part of '_services.dart';

class DateService {
  static DateTime now() {
    return DateTime.now().toLocal();
  }

  static DateTime nowUtc() {
    return now().toUtc();
  }

  static DateTime ymd() {
    return DateTime(now().year, now().month, now().day);
  }

  static DateTime ym1d() {
    return ymd().add(const Duration(days: 1));
  }

  static DateTime ymdUtc() {
    return ymd().toUtc();
  }

  static DateTime ym1dUtc() {
    return ymdUtc().add(const Duration(days: 1));
  }

  static String ymdString() {
    return ymd().toIso8601String();
  }

  static String ymdUtcString() {
    return ymdUtc().toIso8601String();
  }

  static String nowString() {
    return now().toIso8601String();
  }

  static String nowUtcString() {
    return nowUtc().toIso8601String();
  }

  static String format(String format, String date) {
    final dateTime = DateTime.parse(date).toLocal();
    final dateFormat = DateFormat(format).format(dateTime);
    return dateFormat;
  }

  static bool isBefore(String start, String end) {
    return DateTime.parse(start)
        .toLocal()
        .isBefore(DateTime.parse(end).toLocal());
  }

  ///date service difference as String
  static Duration difference(String start, String end) {
    return DateTime.parse(start)
        .toLocal()
        .difference(DateTime.parse(end).toLocal());
  }
}
