part of 'widgets.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
    required this.advancedDrawerController,
    required this.currentTab,
    required this.onTabChange,
  });

  final AdvancedDrawerController advancedDrawerController;
  final String currentTab;
  final Function(String) onTabChange;

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool? isPetaSebaran = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      widget.advancedDrawerController.hideDrawer();
                    },
                    child: SvgPicture.asset(
                      "assets/menu_x.svg",
                      width: 26,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text.rich(TextSpan(
                    text: "Hello,\n",
                    style: AppTheme.title2,
                    children: [TextSpan(text: "Dhafa", style: AppTheme.title3)],
                  )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isPetaSebaran = true;
                        widget.onTabChange('peta sebaran');
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: isPetaSebaran == true
                              ? AppColor.darkPrimary
                              : AppColor.transparent,
                          borderRadius: BorderRadius.circular(6)),
                      child: CustomListTile(
                        svgTitle: "book_map",
                        title: "Peta Sebaran",
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildExpansionTile(
                    index: 1,
                    svgTitle: "air",
                    title: "Air Tanah",
                    children: [
                      CustomListTile(
                        onTap: () {
                          setState(() {
                            isPetaSebaran = false;
                          });
                          widget.onTabChange('mata air');
                        },
                        svgTitle: "point",
                        title: "Mata Air",
                      ),
                      const SizedBox(height: 14),
                      CustomListTile(
                        onTap: () {
                          setState(() {
                            isPetaSebaran = false;
                          });
                          widget.onTabChange('sumur');
                        },
                        svgTitle: "point",
                        title: "Sumur",
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),
                  const SizedBox(height: 4),
                  _buildExpansionTile(
                    index: 2,
                    svgTitle: "database",
                    title: "Master Data",
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Divider(
                        color: AppColor.white,
                        thickness: 0.5,
                      ),
                      const SizedBox(height: 4),
                      ItemList(
                        svgTitle: "settings",
                        title: "Pengaturan",
                      ),
                      const SizedBox(height: 4),
                      ItemList(
                        svgTitle: "logout",
                        title: "Keluar",
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile({
    required int index,
    required String svgTitle,
    required String title,
    List<Widget>? children,
    bool showTrailingIcon = true,
  }) {
    return Theme(
      data: ThemeData(
        iconTheme: IconThemeData(color: AppColor.white),
        unselectedWidgetColor: AppColor.white,
      ),
      child: ExpansionTile(
        key: Key(index.toString()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: AppColor.transparent),
        ),
        iconColor: AppColor.white,
        childrenPadding: EdgeInsets.symmetric(horizontal: 36),
        collapsedIconColor: AppColor.white,
        backgroundColor: AppColor.darkPrimary,
        title: CustomListTile(
          svgTitle: svgTitle,
          title: title,
        ),
        trailing: showTrailingIcon
            ? Icon(
                Icons.keyboard_arrow_down,
                color: AppColor.white,
              )
            : SizedBox(),
        children: children ?? [],
      ),
    );
  }
}
