part of 'pages.dart';

class SumurRequest extends StatefulWidget {
  SumurRequest({
    Key? key,
    this.sumur,
  }) : super(key: key);

  final Sumur? sumur;

  @override
  State<SumurRequest> createState() => _SumurRequestState();
}

class _SumurRequestState extends State<SumurRequest> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;
  late TextEditingController _koordinatController;
  late TextEditingController _manfaatJiwaController;
  late TextEditingController _manfaatIrigasiController;
  late TextEditingController _debitController;
  late TextEditingController _fungsiSumurController;
  late TextEditingController _kondisiSumurController;

  String? _operasi;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.sumur?.name);
    _latitudeController = TextEditingController(
      text: widget.sumur != null
          ? widget.sumur!.koordinat.latitude.toString()
          : '',
    );
    _longitudeController = TextEditingController(
      text: widget.sumur != null
          ? widget.sumur!.koordinat.longitude.toString()
          : '',
    );
    _koordinatController = TextEditingController(
      text: widget.sumur != null
          ? _formatKoordinat(widget.sumur!.koordinat.latitude,
              widget.sumur!.koordinat.longitude)
          : '',
    );
    _manfaatJiwaController =
        TextEditingController(text: widget.sumur?.manfaatJiwa);
    _manfaatIrigasiController =
        TextEditingController(text: widget.sumur?.manfaatIrigasi);
    _debitController =
        TextEditingController(text: widget.sumur?.debit.toString());
    _fungsiSumurController =
        TextEditingController(text: widget.sumur?.fungsiSumur);
    _kondisiSumurController =
        TextEditingController(text: widget.sumur?.kondisiSumur);
    _operasi = widget.sumur?.operasi;

    if (widget.sumur == null) {
      _getCurrentPosition();
    }
  }

  String _formatKoordinat(double? lat, double? long) {
    if (lat != null && long != null) {
      return "${lat.toStringAsFixed(6)} , ${long.toStringAsFixed(6)}";
    }
    return "";
  }

  Future<void> _getCurrentPosition() async {
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
        _koordinatController.text =
            _formatKoordinat(position.latitude, position.longitude);
        _updateLatLong(); // Ini akan memperbarui _latitudeController dan _longitudeController
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
            SizedBox(width: 4.w),
            Text("Data Sumur", style: AppTheme.title),
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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.sumur != null
                        ? "Ubah Data Sumur"
                        : "Input Data Sumur",
                    style: AppTheme.title,
                  ),
                  SizedBox(height: 16.h),
                  CustomFormField(
                    controller: _koordinatController,
                    label: "Koordinat",
                    hintText: "Latitude , Longitude",
                    isLoading: _isLoading,
                  ),
                  SizedBox(height: 16.h),
                  CustomFormField(
                    controller: _fungsiSumurController,
                    label: "Fungsi Sumur",
                    hintText: "Fungsi Sumur",
                  ),
                  SizedBox(height: 16.h),
                  CustomFormField(
                    controller: _manfaatJiwaController,
                    label: "Manfaat Jiwa",
                    hintText: "Manfaat Jiwa",
                  ),
                  SizedBox(height: 16.h),
                  CustomFormField(
                    controller: _manfaatIrigasiController,
                    label: "Manfaat Luas Daerah Irigasi",
                    hintText: "Manfaat Luas Daerah Irigasi",
                  ),
                  SizedBox(height: 16.h),
                  CustomFormField(
                    controller: _debitController,
                    label: "Debit",
                    hintText: "Debit",
                  ),
                  SizedBox(height: 16.h),
                  CustomFormField(
                    controller: _kondisiSumurController,
                    label: "Kondisi Sumur",
                    hintText: "Kondisi Sumur",
                  ),
                  SizedBox(height: 16.h),
                  CustomDropdownField(
                    label: "Status Operasi",
                    value: _operasi,
                    items: ["Operasi", "Tidak Operasi"],
                    onChange: (value) {
                      setState(() {
                        _operasi = value;
                      });
                    },
                    hint: "Status Operasi",
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(double.infinity, 46.h)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                      backgroundColor:
                          MaterialStateProperty.all(AppColor.primary),
                    ),
                    onPressed: _submitData,
                    child: Text(
                      widget.sumur != null ? "Ubah Data" : "Simpan Data",
                      style: AppTheme.button,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitData() {
    _updateLatLong(); // Pastikan latitude dan longitude terupdate dari _koordinatController

    final latitude = double.tryParse(_latitudeController.text);
    final longitude = double.tryParse(_longitudeController.text);

    if (latitude == null || longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Koordinat tidak valid')),
      );
      return;
    }

    final koordinat = Koordinat(latitude: latitude, longitude: longitude);

    final sumur = Sumur(
      name: "belum", // Anda mungkin ingin mengubah ini sesuai kebutuhan
      koordinat: koordinat,
      operasi: _operasi ?? '',
      manfaatJiwa: _manfaatJiwaController.text,
      manfaatIrigasi: _manfaatIrigasiController.text,
      kondisiSumur: _kondisiSumurController.text,
      fungsiSumur: _fungsiSumurController.text,
      debit: _debitController.text.isEmpty ? 0 : double.parse(_debitController.text),
    );

    if (widget.sumur == null) {
      context.read<SumurCubit>().addSumur(sumur);
    } else {
      sumur.id = widget.sumur!.id;
      context.read<SumurCubit>().updateSumur(sumur);
    }

    Navigator.pop(context);
  }

  void _updateLatLong() {
    final koordinatParts = _koordinatController.text.split(',');
    if (koordinatParts.length == 2) {
      final lat = double.tryParse(koordinatParts[0].trim());
      final long = double.tryParse(koordinatParts[1].trim());
      if (lat != null && long != null) {
        _latitudeController.text = lat.toString();
        _longitudeController.text = long.toString();
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _koordinatController.removeListener(_updateLatLong);
    _manfaatJiwaController.dispose();
    _manfaatIrigasiController.dispose();
    _debitController.dispose();
    _fungsiSumurController.dispose();
    _kondisiSumurController.dispose();
    super.dispose();
  }
}
