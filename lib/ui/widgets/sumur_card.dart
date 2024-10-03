part of 'widgets.dart';

class SumurCard extends StatelessWidget {
  const SumurCard({
    required this.sumur,
    super.key,
  });

  final Sumur sumur;

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
                ValueCard(title: "Nama/No Sumur", value: sumur.nama),
                ValueCard(
                    title: "Kode Integrasi", value: sumur.kodeIntegrasi),
                ValueCard(title: "Kota", value: sumur.kota),
                ValueCard(
                    title: "Provinsi ${sumur.provinsi}",
                    value: "Potensi Bencana"),
                ValueCard(
                    title: "Manfaat Jiwa",
                    value: sumur.manfaatJiwa.toString()),
                ValueCard(
                    title: "Manfaat Luas Daerah Irigasi",
                    value: sumur.manfaatLuasDaerah.toString()),
                ValueCard(title: "Debit", value: "${sumur.debit}"),
                ValueCard(title: "Kondisi Sumur", value: sumur.kondisiSumur),
                ValueCard(title: "Fungsi Sumur", value: sumur.fungsiSumur),
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
                          color: sumur.operasi == 'Operasi'
                              ? AppColor.lightGreen
                              : AppColor.danger),
                      child: Text(
                        sumur.operasi,
                        style: AppTheme.semiBold.copyWith(color: sumur.operasi == 'Operasi'
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
                  Get.to(() => DetailSumur(sumur: sumur));
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
