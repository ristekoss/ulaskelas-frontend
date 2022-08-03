part of '_widgets.dart';

// changed from Tag Widget ristek component
class TagLeaderboard extends StatelessWidget {
  /// Creates Tag Widget
  const TagLeaderboard({
    Key? key,
    this.label = 'Kamu',
    this.rank,
  }) : super(key: key);

  /// Specify the label text
  final String label;

  final int? rank;

  @override
  Widget build(BuildContext context) {

    final labels = [
      'Gold',
      'Silver',
      'Bronze',
      'Top 20',
    ];

    final colors = _mapColor();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: colors[0],
        borderRadius: BorderRadius.circular(400),
        border: Border.all(
          color: colors[1],
          width: 2,
        ),
      ),
      child: Text(
        rank == null ? label : labels[rank! <= 3 ? rank!-1 : 3],
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: colors[2],
        ),
      ),
    );
  }

  /// Mapping color base on state
  List<Color> _mapColor() {
    if (rank == null) {
      return [
        BaseColors.purpleHearth,
        BaseColors.purpleHearth,
        BaseColors.white
      ];
    }else if(rank == 1){
      return [
        const Color(0xFFFFD668),
        const Color(0xFFFFC62D),
        const Color(0xFFDDA200),
      ];
    }else if(rank == 2){
      return [
        const Color(0xFFC7C6C4),
        const Color(0xFFB4B4B4),
        const Color(0xFF7D7D7D),
      ];
    }else if(rank == 3){
      return [
        const Color(0xFFCD7F32),
        const Color(0xFFA15810),
        const Color(0xFFAE5906),
      ];
    }else if(rank! < 20){
      return [
        BaseColors.transparent,
        BaseColors.purpleHearth,
        BaseColors.purpleHearth,
      ];
    }
    return [];
  }
}
