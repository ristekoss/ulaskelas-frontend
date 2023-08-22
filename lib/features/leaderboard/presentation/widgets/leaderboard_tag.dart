part of '_widgets.dart';

// changed from Tag Widget ristek component
class TagLeaderboard extends StatelessWidget {
  /// Creates Tag Widget
  const TagLeaderboard({
    super.key,
    this.label = 'Kamu',
    this.rank,
  });

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
        BaseColors.gold1,
        BaseColors.gold3,
        BaseColors.gold2,
      ];
    }else if(rank == 2){
      return [
        BaseColors.silver1,
        BaseColors.silver3,
        BaseColors.silver2,
      ];
    }else if(rank == 3){
      return [
        BaseColors.bronze1,
        BaseColors.bronze3,
        BaseColors.bronze2,
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
