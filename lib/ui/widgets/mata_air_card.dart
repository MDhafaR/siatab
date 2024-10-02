part of 'widgets.dart';

class MataAirCard extends StatelessWidget {
  const MataAirCard({
    required this.latitude,
    required this.longitude,
    required this.operasi,
    required this.manfaatJiwa,
    required this.manfaatIrigasi,
    super.key,
  });

  final double latitude;
  final double longitude;
  final String operasi;
  final String manfaatJiwa;
  final String manfaatIrigasi;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => MataAirRequest(
          mataAir: MataAir(name: "belum ada", koordinat: Koordinat(latitude: latitude, longitude: longitude), manfaatJiwa: manfaatJiwa, operasi: operasi, manfaatIrigasi: manfaatIrigasi)
            ));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                childAspectRatio: 2,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Koordinat",
                        style: AppTheme.caption2.copyWith(color: AppColor.dark),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        "$latitude, $longitude",
                        style: AppTheme.title3.copyWith(color: AppColor.dark),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Operasi",
                          style:
                              AppTheme.caption2.copyWith(color: AppColor.dark)),
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: operasi == 'Operasi'
                                ? AppColor.green
                                : AppColor.danger),
                        child: Text(
                          operasi,
                          style: AppTheme.semiBold,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Manfaat Jiwa",
                          style:
                              AppTheme.caption2.copyWith(color: AppColor.dark)),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        manfaatJiwa,
                        style: AppTheme.title3.copyWith(color: AppColor.dark),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Manfaat Luas Daerah Irigasi",
                          style:
                              AppTheme.caption2.copyWith(color: AppColor.dark)),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        manfaatIrigasi,
                        style: AppTheme.title3.copyWith(color: AppColor.dark),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ]),
          ),
          SizedBox(
            height: 8.h,
          ),
        ],
      ),
    );
  }
}
