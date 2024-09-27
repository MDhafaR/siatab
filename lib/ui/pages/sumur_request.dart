part of 'pages.dart';

class SumurRequest extends StatefulWidget {
  const SumurRequest({super.key});

  @override
  State<SumurRequest> createState() => _SumurRequestState();
}

class _SumurRequestState extends State<SumurRequest> {
  String? _dropValue;

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
            SizedBox(
              width: 4.w,
            ),
            Text(
              "Data Sumur",
              style: AppTheme.title,
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        padding: EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Input Data Sumur",
                style: AppTheme.title,
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomFormField(
                label: "Koordinat",
                hintText: "Koordinat",
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomFormField(
                label: "Fungsi Sumur",
                hintText: "Fungsi Sumur",
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomFormField(
                label: "Manfaat Jiwa",
                hintText: "Manfaat Jiwa",
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomFormField(
                label: "Manfaat Luas Daerah Irigasi",
                hintText: "Manfaat Luas Daerah Irigasi",
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomFormField(
                label: "Debit",
                hintText: "Debit",
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomFormField(
                label: "Kondisi Sumur",
                hintText: "Kondisi Sumur",
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomDropdownField(
                  label: "Status Operasi",
                  value: _dropValue,
                  items: [
                    "Operasi",
                    "Tidak Operasi",
                  ],
                  onChange: (value) {},
                  hint: "Status Operasi"),
              SizedBox(
                height: 16.h,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize:
                          WidgetStateProperty.all(Size(double.infinity, 46.h)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                      backgroundColor: WidgetStateProperty.all(
                        AppColor.primary,
                      )),
                  onPressed: () {},
                  child: Text("Simpan Data", style: AppTheme.button)),
            ],
          ),
        ),
      ),
    );
  }
}
