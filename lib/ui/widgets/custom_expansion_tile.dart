part of 'widgets.dart';


class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: AppColor.superLight)),
      collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: AppColor.superLight)),
      iconColor: AppColor.dark,
      collapsedIconColor: AppColor.darkLight,
      backgroundColor: AppColor.transparent,
      title: Text(title,
          style: AppTheme.title4.copyWith(color: AppColor.superDarkPrimary)),
    );
  }
}