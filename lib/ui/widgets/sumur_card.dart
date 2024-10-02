part of 'widgets.dart';

class SumurCard extends StatelessWidget {
  const SumurCard({
    required this.latitude,
    required this.longitude,
    required this.operasi,
    required this.manfaatJiwa,
    required this.manfaatIrigasi,
    required this.fungsiSumur,
    required this.kondisiSumur,
    required this.debit,
    super.key,
  });

  final double latitude;
  final double longitude;
  final String operasi;
  final String manfaatJiwa;
  final String manfaatIrigasi;
  final String fungsiSumur;
  final String kondisiSumur;
  final double debit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => SumurRequest(
              sumur: Sumur(
                  name: "belum ada",
                  koordinat:
                      Koordinat(latitude: latitude, longitude: longitude),
                  manfaatJiwa: manfaatJiwa,
                  manfaatIrigasi: manfaatIrigasi,
                  operasi: operasi,
                  fungsiSumur: fungsiSumur,
                  debit: debit,
                  kondisiSumur: kondisiSumur),
            ));
      },
      child: Container(
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
                  ValueCard(
                      title: "Nama/No Sumur",
                      value: "Sumur SMAN 4 Bandung timur "),
                  ValueCard(title: "Kode Integrasi", value: "SMR234"),
                  ValueCard(title: "Kota", value: "Bandung"),
                  ValueCard(
                      title: "Provinsi Jawa Barat", value: "Potensi Bencana"),
                  ValueCard(title: "Manfaat Jiwa", value: manfaatJiwa),
                  ValueCard(
                      title: "Manfaat Luas Daerah Irigasi",
                      value: manfaatIrigasi),
                  ValueCard(title: "Debit", value: "$debit"),
                  ValueCard(title: "Kondisi Sumur", value: kondisiSumur),
                  ValueCard(title: "Fungsi Sumur", value: fungsiSumur),
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
                ]),
            Divider(),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 6.5, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColor.primary
                ),
                child: Row(children: [
                  SvgPicture.asset("assets/paper.svg", width: 18,),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text("Detail Data", style: AppTheme.caption2.copyWith(color: AppColor.white),)
                ],),
              ),
              SizedBox(
                width: 8.w,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 6.5, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColor.green
                ),
                child: Row(children: [
                  SvgPicture.asset("assets/book_map.svg", width: 18,),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text("Koordinat Lokasi", style: AppTheme.caption2.copyWith(color: AppColor.white),)
                ],),
              ),
            ],)
          ],
        ),
      ),
    );
  }
}
