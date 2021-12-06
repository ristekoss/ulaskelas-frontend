// Created by Muhamad Fauzi Ridwan on 05/12/21.

part of '_widgets.dart';

class DetailView extends StatelessWidget {
  const DetailView({
    Key? key,
    required this.title,
    required this.description,
    this.isEmptyView = false,
  }) : super(key: key);

  final String title;
  final String description;
  final bool isEmptyView;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 40,
      ),
      children: [
        HeightSpace(size.height * .1),
        Image.asset(
          isEmptyView ? Ilustration.notfound : Ilustration.onboard3,
          width: size.width * .6,
        ),
        const HeightSpace(20),
        Text(
          title,
          style: FontTheme.poppins14w700black().copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const HeightSpace(10),
        Text(
          description,
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
        ),
        const HeightSpace(20),
      ],
    );
  }
}
