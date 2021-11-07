// Created by Muhamad Fauzi Ridwan on 7/17/21.

part of '_environment.dart';

class Flavor {
  ///named private constructor
  const Flavor._(this.value, this.type);
  static const development =
      Flavor._(Constants.ulaskelas, Constants.development);
  static const production = Flavor._(Constants.ulaskelas, Constants.production);

  final String value;
  final String type;

  static List<Flavor> get values => [
        development,
        production,
      ];
}
