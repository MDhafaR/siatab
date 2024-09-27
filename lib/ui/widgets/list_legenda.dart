part of 'widgets.dart';

class ListLegenda extends StatelessWidget {
  const ListLegenda({
    required this.svgTitle,
    required this.title,
    super.key,
  });

  final String svgTitle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/$svgTitle.svg",
          width: 22,
        ),
        SizedBox(
          width: 7.w,
        ),
        Text("Intake Sungai Aktif",
            style: AppTheme.caption2.copyWith(color: AppColor.dark)),
      ],
    );
  }
}