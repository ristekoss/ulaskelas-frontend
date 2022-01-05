part of '_datasources.dart';

class DummyMatkul {
  static final List<MatkulModelHome> matkul = [
    MatkulModelHome(
      shortName: 'PL',
      nama: 'Pemrograman Lanjut',
      statusWajib: 'Wajib IK',
      semester: 5,
      banyakUlasan: 8,
    ),
    MatkulModelHome(
      shortName: 'BD',
      nama: 'Basis Data',
      statusWajib: 'Wajib IK & SI',
      semester: 5,
      banyakUlasan: 8,
    ),
    MatkulModelHome(
      shortName: 'AP',
      nama: 'Arsitektur dan Pemrograman Aplikasi Perusahaan',
      statusWajib: 'Wajib SI',
      semester: 5,
      banyakUlasan: 8,
    ),
    MatkulModelHome(
      shortName: 'AN',
      nama: 'Analisis Numerik',
      statusWajib: 'Wajib IK',
      semester: 5,
      banyakUlasan: 8,
    ),
  ];
}
