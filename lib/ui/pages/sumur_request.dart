part of 'pages.dart';

class SumurRequest extends StatefulWidget {
  SumurRequest(
      {super.key,
      this.tapKoordinat,
      this.tapDropValue,
      this.tapManfaatJiwa,
      this.tapManfaatLuas,
      this.tapDebit,
      this.tapFungsiSumur,
      this.tapKondisiSumur});

  TextEditingController? tapKoordinat;
  String? tapDropValue;
  TextEditingController? tapManfaatJiwa;
  TextEditingController? tapManfaatLuas;
  TextEditingController? tapDebit;
  TextEditingController? tapFungsiSumur;
  TextEditingController? tapKondisiSumur;

  @override
  State<SumurRequest> createState() => _SumurRequestState();
}

class _SumurRequestState extends State<SumurRequest> {
  String? _dropValue;
  TextEditingController _koordinatController = TextEditingController();
  TextEditingController _manfaatJiwaController = TextEditingController();
  TextEditingController _manfaatLuasController = TextEditingController();
  TextEditingController _debitController = TextEditingController();
  TextEditingController _fungsiSumurController = TextEditingController();
  TextEditingController _kondisiSumurController = TextEditingController();
  Position? _currentPosition;
  bool _isLoading = false;

  @override
  void initState() {
    _getCurrentPosition();
    super.initState();
  }

  Future<void> _getCurrentPosition() async {
    if (widget.tapKoordinat != null) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final isLocationGranted = await Utility.instance.checkLocationPermission();
    if (!isLocationGranted) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
        _koordinatController.text =
            "${_currentPosition?.latitude} , ${_currentPosition?.longitude}";
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
        child: Container(
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
                  widget.tapManfaatJiwa != null
                      ? "Ubah Data Sumur"
                      : "Input Data Sumur",
                  style: AppTheme.title,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomFormField(
                  controller: widget.tapKoordinat ?? _koordinatController,
                  label: "Koordinat",
                  hintText: "Koordinat",
                  isLoading: _isLoading,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomFormField(
                  controller: widget.tapFungsiSumur ?? _fungsiSumurController,
                  label: "Fungsi Sumur",
                  hintText: "Fungsi Sumur",
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomFormField(
                  controller: widget.tapManfaatJiwa ?? _manfaatJiwaController,
                  label: "Manfaat Jiwa",
                  hintText: "Manfaat Jiwa",
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomFormField(
                  controller: widget.tapManfaatLuas ?? _manfaatLuasController,
                  label: "Manfaat Luas Daerah Irigasi",
                  hintText: "Manfaat Luas Daerah Irigasi",
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomFormField(
                  controller: widget.tapDebit ?? _debitController,
                  label: "Debit",
                  hintText: "Debit",
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomFormField(
                  controller: widget.tapKondisiSumur ?? _kondisiSumurController,
                  label: "Kondisi Sumur",
                  hintText: "Kondisi Sumur",
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomDropdownField(
                    label: "Status Operasi",
                    value: widget.tapDropValue ?? _dropValue,
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
                        minimumSize: WidgetStateProperty.all(
                            Size(double.infinity, 46.h)),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                        backgroundColor: WidgetStateProperty.all(
                          AppColor.primary,
                        )),
                    onPressed: () {},
                    child: Text(
                        widget.tapManfaatJiwa != null
                            ? "Ubah Data"
                            : "Simpan Data",
                        style: AppTheme.button)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
