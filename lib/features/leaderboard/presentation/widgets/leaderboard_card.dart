part of '_widgets.dart';

class LeaderboardCard extends StatelessWidget {
  const LeaderboardCard({
    required this.rank, required this.model, super.key,
  });

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
                style: FontTheme.poppins12w400black(),
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
      BaseColors.gold3,
      BaseColors.silver3,
      BaseColors.bronze3,
    ];

    final baseColors = <Color>[
      BaseColors.gold1,
      BaseColors.silver1,
      BaseColors.bronze1,
    ];

    final textColors = [
      BaseColors.gold2,
      BaseColors.silver2,
      BaseColors.bronze3,
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
