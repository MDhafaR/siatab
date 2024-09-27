part of 'widgets.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.svgTitle,
    required this.title,
    this.onTap,
    super.key,
  });

  final String svgTitle;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/$svgTitle.svg",
            width: 22.w,
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