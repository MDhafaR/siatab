part of 'pages.dart';

class DetailSumur extends StatelessWidget {
  const DetailSumur({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      appBar: CustomAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/air.svg",
              width: 18.w,
              colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
            ),
            SizedBox(width: 4.w),
            Text("Data Sumur", style: AppTheme.title),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Text(
                      "Detail Data Sumur",
                      style: AppTheme.title.copyWith(color: AppColor.dark),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 6.5, horizontal: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColor.orange),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/edit.svg",
                                width: 18,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "Ubah Data",
                                style: AppTheme.caption2
                                    .copyWith(color: AppColor.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 6.5, horizontal: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColor.danger),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/trash.svg",
                                width: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Informasi Dasar",
                      style: AppTheme.medium.copyWith(color: AppColor.dark),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
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
                          ValueCard(title: "Manfaat Jiwa", value: "Air Baku"),
                          ValueCard(
                              title: "Manfaat Luas Daerah Irigasi",
                              value: "manfaatIrigasi"),
                          ValueCard(title: "Debit", value: "20"),
                          ValueCard(title: "Kondisi Sumur", value: "Baik"),
                          ValueCard(
                              title: "Fungsi Sumur", value: "Potensi Bencana"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Operasi",
                                  style: AppTheme.caption2
                                      .copyWith(color: AppColor.dark)),
                              SizedBox(
                                height: 4.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppColor.danger),
                                child: Text(
                                  "Tidak Operasi",
                                  style: AppTheme.semiBold,
                                ),
                              )
                            ],
                          ),
                        ]),
                    Divider(),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      "Informasi Wilayah Sungai",
                      style: AppTheme.medium.copyWith(color: AppColor.dark),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        childAspectRatio: 2.2,
                        children: [
                          ValueCard(
                              title: "Nama Balai", value: "BBWS Ciliwung"),
                          ValueCard(title: "Nama WS", value: "WS Bangka"),
                          ValueCard(title: "Nama DAS", value: "DAS KONOHA"),
                          ValueCard(title: "Kota", value: "Bandung"),
                          ValueCard(title: "Provinsi", value: "Jawa Barat"),
                          ValueCard(title: "Kecamatan", value: "ABOY"),
                          ValueCard(title: "Kelurahan", value: "ARMISE"),
                        ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
