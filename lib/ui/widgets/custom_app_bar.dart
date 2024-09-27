part of 'widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Color? foregroundColor;
  final Color? startColor;
  final Color? endColor;
  final Color? backgroundColor;
  final bool? customColor;
  final Widget? leading;
  final Function()? tapLeading;

  CustomAppBar(
      {Key? key,
      required this.title,
      this.foregroundColor,
      this.startColor,
      this.endColor,
      this.backgroundColor,
      this.customColor,
      this.leading,
      this.tapLeading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            startColor ?? Colors.white,
            endColor ?? Colors.white,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        title: title,
        centerTitle: true,
        backgroundColor: customColor != null
            ? backgroundColor ?? Colors.transparent
            : Colors.white,
        surfaceTintColor:
            customColor != null ? Colors.transparent : Colors.white,
        elevation: 0,
        foregroundColor: foregroundColor ?? Colors.black,
        leading: IconButton(
          iconSize: 24,
          padding: const EdgeInsets.all(0),
          onPressed: tapLeading ??
              () {
                Get.back();
              },
          icon: leading ??
              Icon(
                Icons.arrow_back,
                color: AppColor.primary,
              ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
