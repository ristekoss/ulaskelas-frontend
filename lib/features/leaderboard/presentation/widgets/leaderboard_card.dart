part of '_widgets.dart';

class LeaderboardCard extends StatelessWidget {
  const LeaderboardCard({
    Key? key,
    required this.rank,
    required this.model,
  }) : super(key: key);

  final int rank;
  final LeaderboardModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: BaseColors.gray3,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: ListTile(
              minLeadingWidth: 10,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (rank > 3)
                    SizedBox(
                      height: 28,
                      width: 28,
                      child: Center(
                        child: Text(
                          '$rank',
                          style: FontTheme.poppins14w700black(),
                        ),
                      ),
                    )
                  else
                    _buildRank(rank),
                ],
              ),
              title: Text(
                model.name,
                style: FontTheme.poppins12w600black(),
              ),
              subtitle: Text(
                'Total ${model.likesCount} Ulasan Disukai',
              ),
              trailing: profileRM.state.profile.username == model.username
                  ? const TagLeaderboard()
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRank(int rank) {
    final borderColors = <Color>[
      const Color(0xFFFFC62D),
      const Color(0xFFB4B4B4),
      const Color(0xFFA15810),
    ];

    final baseColors = <Color>[
      const Color(0xFFFFD668),
      const Color(0xFFC7C6C4),
      const Color(0xFFCD7F32),
    ];

    final textColors = [
      const Color(0xFFDDA200),
      const Color(0xFF7D7D7D),
      const Color(0xFFAE5906),
    ];

    return Container(
      height: 28,
      width: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColors[rank - 1],
          width: 3,
        ),
        color: baseColors[rank - 1],
      ),
      child: Center(
        child: Text(
          '$rank',
          style: FontTheme.poppins14w700black().apply(
            color: textColors[rank - 1],
          ),
        ),
      ),
    );
  }
}
