part of 'widgets.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    required this.svgTitle,
    required this.title,
    super.key,
  });

  final String svgTitle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      width: double.infinity,
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/$svgTitle.svg",
            width: 22,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: AppTheme.title4,
          )
        ],
      ),
    );
  }
}