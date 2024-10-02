part of 'widgets.dart';

class ValueCard extends StatelessWidget {
  const ValueCard({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.caption2.copyWith(color: AppColor.dark),
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          value,
          style: AppTheme.title3.copyWith(color: AppColor.dark),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}