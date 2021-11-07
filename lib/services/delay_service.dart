// Created by Muhamad Fauzi Ridwan on 01/08/21.

part of '_services.dart';

class DelayService {
  ///Better performance
  static Future<void> smallDelay() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }

  static Future<void> mediumDelay() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }
}
