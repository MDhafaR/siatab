part of 'widgets.dart';

class MataAirCard extends StatelessWidget {
  const MataAirCard({
    required this.mataAir,
    super.key,
  });

  final MataAir mataAir;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              childAspectRatio: 2.2,
              children: [
                ValueCard(title: "Nama/No mataAir", value: mataAir.nama),
                ValueCard(
                    title: "Kode Integrasi", value: mataAir.kodeIntegrasi),
                ValueCard(title: "Kota", value: mataAir.kota),
                ValueCard(
                    title: "Provinsi ${mataAir.provinsi}",
                    value: "Potensi Bencana"),
                ValueCard(
                    title: "Manfaat Jiwa",
                    value: mataAir.manfaatJiwa.toString()),
                ValueCard(
                    title: "Manfaat Luas Daerah Irigasi",
                    value: mataAir.manfaatLuasDaerah.toString()),
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
                          color: mataAir.operasi == 'Operasi'
                              ? AppColor.lightGreen
                              : AppColor.danger),
                      child: Text(
                        mataAir.operasi,
                        style: AppTheme.semiBold.copyWith(color: mataAir.operasi == 'Operasi'
                              ? AppColor.green
                              : AppColor.white),
                      ),
                    )
                  ],
                ),
              ]),
          Divider(),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => DetailMataAir(mataAir: mataAir));
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.5, horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColor.primary),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/paper.svg",
                        width: 18,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        "Detail Data",
                        style:
                            AppTheme.caption2.copyWith(color: AppColor.white),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 6.5, horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColor.green),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/book_map.svg",
                      width: 18,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "Koordinat Lokasi",
                      style:
                          AppTheme.caption2.copyWith(color: AppColor.white),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
