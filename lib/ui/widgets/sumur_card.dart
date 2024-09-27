part of 'widgets.dart';

class SumurCard extends StatelessWidget {
  const SumurCard({
    required this.koordinat,
    required this.operasi,
    required this.manfaatJiwa,
    required this.manfaatIrigasi,
    required this.fungsiSumur,
    required this.kondisiSumur,
    required this.debit,
    super.key,
  });

  final String koordinat;
  final String operasi;
  final String manfaatJiwa;
  final String manfaatIrigasi;
  final String fungsiSumur;
  final String kondisiSumur;
  final double debit;

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
                      koordinat,
                      style: AppTheme.title3.copyWith(color: AppColor.dark),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fungsi Sumur",
                      style: AppTheme.caption2.copyWith(color: AppColor.dark),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      fungsiSumur,
                      style: AppTheme.title3.copyWith(color: AppColor.dark),
                      overflow: TextOverflow.ellipsis,
                    ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Debit",
                        style:
                            AppTheme.caption2.copyWith(color: AppColor.dark)),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "$debit",
                      style: AppTheme.title3.copyWith(color: AppColor.dark),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kondisi Sumur",
                        style:
                            AppTheme.caption2.copyWith(color: AppColor.dark)),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      kondisiSumur,
                      style: AppTheme.title3.copyWith(color: AppColor.dark),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ]),
          Divider(),
          SizedBox(
            height: 16.h,
          ),
          Row(children: [
            Expanded(
                child: Text("Status Operasi",
                    style: AppTheme.caption2.copyWith(color: AppColor.dark))),
            Flexible(
                child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color:
                      operasi == 'Operasi' ? AppColor.green : AppColor.danger),
              child: Text(
                operasi,
                style: AppTheme.semiBold,
              ),
            ))
          ])
        ],
      ),
    );
  }
}
