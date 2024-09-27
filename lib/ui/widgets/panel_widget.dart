part of 'widgets.dart';

class PanelWidget extends StatelessWidget {
  PanelWidget({required this.controller, required this.isFull, super.key});

  final ScrollController controller;
  bool isFull = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right:  isFull ? 24 : 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 7.h,
          ),
          Center(
            child: Container(
              width: 20.w,
              height: 3.h,
              decoration: BoxDecoration(
                  color: AppColor.darkWhite,
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          SizedBox(
            height: 13.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter Infrastruktur",
                    style: AppTheme.title.copyWith(color: AppColor.superDark),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  CustomExpansionTile(
                    title: "Pilih Infrastruktur",
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  CustomExpansionTile(
                    title: "Pilih Provinsi",
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  CustomExpansionTile(
                    title: "Cari Infrastruktur",
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  DashLine(
                      ketebalan: 1,
                      warna: AppColor.superLight,
                      jarakAntarGaris: 3,
                      panjangGaris: 5),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    "Jenis Peta",
                    style: AppTheme.title.copyWith(color: AppColor.superDark),
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    title: Text("OpenStreetMap"),
                    value: "",
                    groupValue: "",
                    onChanged: (value) {},
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    title: Text("OpenTopoMap"),
                    value: "",
                    groupValue: "",
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          minimumSize: WidgetStateProperty.all(
                              Size(double.infinity, 46.h)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                          backgroundColor: WidgetStateProperty.all(
                            AppColor.primary,
                          )),
                      onPressed: () {},
                      child: Text("Simpan Data", style: AppTheme.button)),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
