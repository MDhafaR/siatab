part of 'widgets.dart';

class DialogWidget extends StatefulWidget {
  const DialogWidget({
    super.key,
  });

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  int? indexTab;

  @override
  void initState() {
    indexTab = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, 75.h),
      child: Dialog(
        backgroundColor: AppColor.transparent,
        alignment: Alignment.topCenter,
        insetPadding: EdgeInsets.all(0),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/intake_sungai_aktif.svg"),
                      SizedBox(
                        width: 5.5.w,
                      ),
                      Text(
                        "SUMUR AIR TANAH SMAN 4 BANDUNG",
                        style: AppTheme.caption5,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: AppColor.darkWhite,
                        )),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            FromToIcon(),
                            SizedBox(
                              width: 12.w,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextLocation(
                                    title: 'Lokasi Anda Saat Ini',
                                    streetName: 'Jln. Sripohaci No.126',
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  TextLocation(
                                    title: 'Lokasi Site',
                                    streetName:
                                        'Sumur Air Tanah SMAN 4 Bandung',
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text.rich(TextSpan(
                            text: "Lokasi Site ",
                            style: AppTheme.map2,
                            children: [
                              TextSpan(text: "20 Meter ", style: AppTheme.map3),
                              TextSpan(text: "dari lokasi anda saat ini"),
                            ]))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    shape: Border.all(color: AppColor.transparent),
                    iconColor: AppColor.darkLight,
                    backgroundColor: AppColor.transparent,
                    title: Text("Informasi Site"),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  indexTab = 0;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        2), // Tambahkan margin untuk jarak antar item
                                decoration: BoxDecoration(
                                  color: indexTab == 0
                                      ? AppColor.primary
                                      : AppColor.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "Informasi Dasar",
                                  textAlign: TextAlign
                                      .center, // Tambahkan ini untuk memastikan teks berada di tengah
                                  style: AppTheme.map3.copyWith(
                                    color: indexTab == 0
                                        ? AppColor.white
                                        : AppColor.dark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  indexTab = 1;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: indexTab == 1
                                      ? AppColor.primary
                                      : AppColor.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "Lokasi",
                                  textAlign: TextAlign.center,
                                  style: AppTheme.map3.copyWith(
                                    color: indexTab == 1
                                        ? AppColor.white
                                        : AppColor.dark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  indexTab = 2;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: indexTab == 2
                                      ? AppColor.primary
                                      : AppColor.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "Photo",
                                  textAlign: TextAlign.center,
                                  style: AppTheme.map3.copyWith(
                                    color: indexTab == 2
                                        ? AppColor.white
                                        : AppColor.dark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      if (indexTab == 0) ...[
                        InformasiDasarWidget(
                          kedalaman: 65,
                          pumpingTest: 0.8,
                          debitPompa: 0.8,
                          idle: 0.8,
                        )
                      ]else if(indexTab == 1) ...[
                        LokasiWidget(
                          provinsi: 65,
                          kota: 0.8,
                          kecamatan: 0.8,
                          kelurahan: 0.8,
                        )
                      ]else if(indexTab == 2) ...[
                        PhotoWidget()
                      ]
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColor.danger.withOpacity(0.1),
      ),
      padding: EdgeInsets.all(8),
      child: Row(children: [
        SvgPicture.asset("assets/red_info.svg", width: 18),
        SizedBox(
          width: 16.w,
        ),
        Text("Belum ada foto", style: AppTheme.map2.copyWith(color: AppColor.danger),)
      ],),
    );
  }
}

class LokasiWidget extends StatelessWidget {
  const LokasiWidget({
    required this.provinsi,
    required this.kota,
    required this.kecamatan,
    required this.kelurahan,
    super.key,
  });

  final int provinsi;
  final double kota;
  final double kecamatan;
  final double kelurahan;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColor.darkWhite,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          ListInformasiDasar(
            title: 'Provinsi',
            value: '$provinsi (m)',
          ),
          SizedBox(height: 8),
          DashLine(
            ketebalan: 1,
            warna: AppColor.darkWhite,
            jarakAntarGaris: 3,
            panjangGaris: 5,
          ),
          SizedBox(height: 8),
          ListInformasiDasar(
            title: 'Kota',
            value: '$kota (1/detik)',
          ),
          SizedBox(height: 8),
          DashLine(
            ketebalan: 1,
            warna: AppColor.darkWhite,
            jarakAntarGaris: 3,
            panjangGaris: 5,
          ),
          SizedBox(height: 8),
          ListInformasiDasar(
            title: 'Kecamatan',
            value: '$kecamatan (1/detik)',
          ),
          DashLine(
            ketebalan: 1,
            warna: AppColor.darkWhite,
            jarakAntarGaris: 3,
            panjangGaris: 5,
          ),
          SizedBox(height: 8),
          ListInformasiDasar(
            title: 'Kelurahan',
            value: '$kelurahan (1/detik)',
          ),
        ],
      ),
    );
  }
}

class InformasiDasarWidget extends StatelessWidget {
  const InformasiDasarWidget({
    required this.kedalaman,
    required this.pumpingTest,
    required this.debitPompa,
    required this.idle,
    super.key,
  });

  final int kedalaman;
  final double pumpingTest;
  final double debitPompa;
  final double idle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColor.darkWhite,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          ListInformasiDasar(
            title: 'Kedalaman',
            value: '$kedalaman (m)',
          ),
          SizedBox(height: 8),
          DashLine(
            ketebalan: 1,
            warna: AppColor.darkWhite,
            jarakAntarGaris: 3,
            panjangGaris: 5,
          ),
          SizedBox(height: 8),
          ListInformasiDasar(
            title: 'Pumping Test',
            value: '$pumpingTest (1/detik)',
          ),
          SizedBox(height: 8),
          DashLine(
            ketebalan: 1,
            warna: AppColor.darkWhite,
            jarakAntarGaris: 3,
            panjangGaris: 5,
          ),
          SizedBox(height: 8),
          ListInformasiDasar(
            title: 'Debit Pompa',
            value: '$debitPompa (1/detik)',
          ),
          DashLine(
            ketebalan: 1,
            warna: AppColor.darkWhite,
            jarakAntarGaris: 3,
            panjangGaris: 5,
          ),
          SizedBox(height: 8),
          ListInformasiDasar(
            title: 'Idle',
            value: '$idle (1/detik)',
          ),
        ],
      ),
    );
  }
}

class ListInformasiDasar extends StatelessWidget {
  const ListInformasiDasar({
    required this.title,
    required this.value,
    super.key,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40, top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    title,
                    style: AppTheme.map2.copyWith(color: AppColor.dark),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    value,
                    style: AppTheme.caption4,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextLocation extends StatelessWidget {
  const TextLocation({
    required this.title,
    required this.streetName,
    super.key,
  });

  final String title;
  final String streetName;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          text: "$title\n",
          style: AppTheme.map,
          children: [TextSpan(text: streetName, style: AppTheme.map2)]),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class FromToIcon extends StatelessWidget {
  const FromToIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/location_form.svg",
          width: 24,
        ),
        SizedBox(
          height: 6.h,
        ),
        SvgPicture.asset(
          "assets/dot.svg",
          width: 2,
        ),
        SizedBox(
          height: 6.h,
        ),
        SvgPicture.asset(
          "assets/dot.svg",
          width: 2,
        ),
        SizedBox(
          height: 6.h,
        ),
        SvgPicture.asset(
          "assets/dot.svg",
          width: 2,
        ),
        SizedBox(
          height: 6.h,
        ),
        SvgPicture.asset(
          "assets/location_to.svg",
          width: 24,
        ),
      ],
    );
  }
}

void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: AppColor.transparent,
    builder: (BuildContext context) {
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: 42), child: DialogWidget());
    },
  );
}
