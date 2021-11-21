part of '_datasources.dart';

class DummyUlasan {
  static final List<UlasanUserModel> ulasan = [
    UlasanUserModel(
        matkul: DummyMatkul.matkul[0],
        ulasan: 'Quando ambulabat agendis admonere tela qualis actio. '
            'Si ad corpus, quae plorem is para siempre edomamus '
            'lorem ipsum',
        status: 'Approved',
        tanggal: '12/07/2021'),
    UlasanUserModel(
        matkul: DummyMatkul.matkul[1],
        ulasan: 'Quando ambulabat agendis admonere tela qualis actio. '
            'Si ad corpus, quae plorem is para siempre edomamus '
            'lorem ipsum',
        status: 'Pending',
        tanggal: '12/07/2021'),
    UlasanUserModel(
        matkul: DummyMatkul.matkul[2],
        ulasan: 'Quando ambulabat agendis admonere tela qualis actio. '
            'Si ad corpus, quae plorem is para siempre edomamus '
            'lorem ipsum',
        status: 'Rejected',
        tanggal: '12/07/2021'),
  ];
}
