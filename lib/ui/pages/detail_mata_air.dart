part of 'pages.dart';

class DetailMataAir extends StatelessWidget {
  const DetailMataAir({super.key, required this.mataAir});

  final MataAir mataAir;

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
            Text("Data Mata Air", style: AppTheme.title),
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
                      "Detail Data Mata Air",
                      style: AppTheme.title.copyWith(color: AppColor.dark),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => MataAirRequest(mataAir: mataAir));
                        },
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
                        onTap: () {
                          context
                              .read<MataAirCubit>()
                              .deleteMataAir(mataAir.id!);
                          Get.back();
                        },
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
                              title: "Nama Mata Air", value: mataAir.nama),
                          ValueCard(
                              title: "Kode Integrasi",
                              value: mataAir.kodeIntegrasi),
                          ValueCard(
                              title: "Manfaat Jiwa",
                              value: mataAir.manfaatJiwa),
                          ValueCard(
                              title: "Manfaat Luas Daerah Irigasi",
                              value: mataAir.manfaatLuasDaerah),
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
                                    color: mataAir.operasi == 'Operasi'
                                        ? AppColor.lightGreen
                                        : AppColor.danger),
                                child: Text(
                                  mataAir.operasi,
                                  style: AppTheme.semiBold.copyWith(
                                      color: mataAir.operasi == 'Operasi'
                                          ? AppColor.green
                                          : AppColor.danger),
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
                              title: "Nama Balai", value: mataAir.namaBalai),
                          ValueCard(title: "Nama WS", value: mataAir.namaWs),
                          ValueCard(title: "Nama DAS", value: mataAir.namaDas),
                          ValueCard(title: "Kota", value: mataAir.kota),
                          ValueCard(title: "Provinsi", value: mataAir.provinsi),
                          ValueCard(
                              title: "Kecamatan", value: mataAir.kecamatan),
                          ValueCard(
                              title: "Kelurahan", value: mataAir.kelurahan),
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
