part of '_pages.dart';

class GuidelinePage extends StatelessWidget {
  const GuidelinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final guidelineDo = <String>[
      'Menggunakan bahasa yang sopan.',
      'Menyampaikan ulasan dengan sudut pandang objektif.',
      '''
Mengulas kelas yang sudah diambil, 
bukan dosen yang mengampu kelas tersebut.''',
      'Menyampaikan ulasan kelas sejujur-jujurnya dan sekomprehensif mungkin.',
      '''
Menuliskan ulasan dengan tujuan untuk
membantu teman-teman lainnya yang belum mengambil kelas tersebut.''',
    ];

    final guidelineDont = <String>[
      'Menyampaikan ulasan dengan sudut pandang objektif.',
      '''
Menambah tag yang kurang relevan dengan mata kuliah yang diulas, 
      seperti: "Nilai tidak wangy" dsb..''',
      '''
Melibatkan unsur Suku, Ras, Agama (SARA) maupun unsur sosial dalam review.''',
      'Menulis ujaran kebencian',
      '''
Menulis review yang berpotensi mencela nama "Fakultas Ilmu Komputer 
Universitas Indonesia" maupun "Universitas Indonesia"''',
      '''
Menyebarluaskan informasi dari mata kuliah yang (mungkin) bersifat konfidensial''',
    ];

    return Scaffold(
      appBar: BaseAppBar(
        label: 'Guideline',
        onBackPress: () => nav.pop<void>(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Do's",
                style: FontTheme.poppins18w700black(),
              ),
              _unorderedList(guidelineDo),
              const HeightSpace(
                18,
              ),
              Text(
                "Don't's",
                style: FontTheme.poppins18w700black(),
              ),
              Text(
                'Ulasan yang dikategorikan semua (atau) salah satu dari '
                'kriteria berikut akan langsung dihapus oleh admin '
                'UlasKelas.',
                style: FontTheme.poppins12w600black().apply(
                  color: BaseColors.danger,
                ),
                textAlign: TextAlign.justify,
              ),
              _unorderedList(
                guidelineDont,
              ),
              const HeightSpace(
                18,
              ),
              Text(
                'Contoh Ulasan yang Baik',
                style: FontTheme.poppins18w700black(),
              ),
              Text(
                '''
Mata kuliah XX merupakan mata kuliah yang mengajarkan tentang pemrograman fundamental beserta dasar dasar dari ilmu komputer. Mata kuliah XX memiliki 3 kuis dan 4 kali tugas pemrograman. Saya merasa mata kuliah XX sangat menyenangkan karena kebanyakan tugasnya adalah pemrograman praktikal sehingga bisa langsung mencoba apa yang dipelajari. Saya sangat merekomendasikan teman-teman yang ingin belajar pemrograman terutama dasar dari pemrograman untuk mengambil mata kuliah ini.
#pemrograman #praktikal
                ''',
                style: FontTheme.poppins12w500black(),
                textAlign: TextAlign.justify,
              ),
              Text(
                'Contoh Ulasan yang Buruk',
                style: FontTheme.poppins18w700black(),
              ),
              Text(
                '''
Mata kuliah XX yang saya ambil diajar oleh Bapak XX. Saya kurang suka dengan cara mengajar Bapak ZZ karena sering memberikan tugas. Terlebih lagi, asisten dosen Kak YY sangat tidak adil dalam memberikan nilai. Saya berharap kurikulum mata kuliah XX diganti karena sangat menguntungkan teman teman yang memiliki sirkel atau kelompok tertentu.
#nilai-wangy #auto-A #santai
                ''',
                style: FontTheme.poppins12w500black(),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _unorderedList(List<String> texts) {
    final widgetList = <Widget>[];
    for (final text in texts) {
      // Add list item
      widgetList.add(_unorderedItem(text));
    }

    return Column(children: widgetList);
  }

  Widget _unorderedItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '• ',
          style: FontTheme.poppins12w500black(),
        ),
        Expanded(
          child: Text(
            text,
            style: FontTheme.poppins12w500black(),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
