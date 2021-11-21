part of '_models.dart';

class UlasanUserModel {
  UlasanUserModel({
    required this.matkul,
    required this.ulasan,
    required this.status,
    required this.tanggal,
  });

  MatkulModelHome matkul;
  String ulasan;
  String status;
  String tanggal;
}
