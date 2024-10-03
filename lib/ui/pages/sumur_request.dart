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
  late TextEditingController _kodeIntegrasiController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;
  late TextEditingController _koordinatController;
  late TextEditingController _manfaatJiwaController;
  late TextEditingController _manfaatLuasDaerahController;
  late TextEditingController _debitController;
  late TextEditingController _fungsiSumurController;
  late TextEditingController _kondisiSumurController;

  String? _operasi;
  String? _namaBalai;
  String? _namaWS;
  String? _namaDAS;
  String? _kota;
  String? _provinsi;
  String? _kecamatan;
  String? _kelurahan;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.sumur?.nama);
    _kodeIntegrasiController = TextEditingController(text: widget.sumur?.kodeIntegrasi);
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
    _manfaatLuasDaerahController =
        TextEditingController(text: widget.sumur?.manfaatLuasDaerah);
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 11.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    widget.sumur != null
                        ? "Ubah Data Sumur"
                        : "Input Data Sumur",
                    style: AppTheme.title.copyWith(color: AppColor.dark),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Container(
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
                            "Informasi Dasar",
                            style:
                                AppTheme.medium.copyWith(color: AppColor.dark),
                          ),
                          SizedBox(height: 16.h),
                          CustomFormField(
                            controller: _kodeIntegrasiController,
                            label: "Kode Integrasi",
                            hintText: "-",
                          ),
                          SizedBox(height: 16.h),
                          CustomFormField(
                            controller: _nameController,
                            label: "Nama/No Sumur",
                            hintText: "Nama / No Sumur",
                          ),
                          SizedBox(height: 16.h),
                          CustomFormField(
                            controller: _koordinatController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9 ,\-.]')),
                              CoordinateFormatter(),
                            ],
                            label: "Koordinat",
                            hintText: "Latitude , Longitude",
                            isLoading: _isLoading,
                          ),
                          SizedBox(height: 16.h),
                          CustomFormField(
                            controller: _manfaatJiwaController,
                            label: "Manfaat Jiwa",
                            hintText: "Manfaat Jiwa",
                          ),
                          SizedBox(height: 16.h),
                          CustomFormField(
                            controller: _manfaatLuasDaerahController,
                            label: "Manfaat Luas Daerah Irigasi",
                            hintText: "Manfaat Luas Daerah Irigasi",
                          ),
                          SizedBox(height: 16.h),
                          CustomFormField(
                            controller: _debitController,
                            label: "Debit",
                            hintText: "Debit",
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                          ),
                          SizedBox(height: 16.h),
                          CustomFormField(
                            controller: _kondisiSumurController,
                            label: "Kondisi Sumur",
                            hintText: "Kondisi Sumur",
                          ),
                          SizedBox(height: 16.h),
                          CustomFormField(
                            controller: _fungsiSumurController,
                            label: "Fungsi Sumur",
                            hintText: "Fungsi Sumur",
                          ),
                          SizedBox(height: 16.h),
                          CustomDropdownField(
                            label: "Status Operasi",
                            value: widget.sumur?.operasi ?? _operasi,
                            items: ["Operasi", "Tidak Operasi"],
                            onChange: (value) {
                              setState(() {
                                _operasi = value;
                              });
                            },
                            hint: "Status Operasi",
                          ),
                          SizedBox(height: 16.h),
                          Divider(),
                          SizedBox(height: 16.h),
                          Text(
                            "Informasi Wilayah Sungai",
                            style:
                                AppTheme.medium.copyWith(color: AppColor.dark),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomDropdownField(
                            label: "Nama Balai",
                            value: widget.sumur?.namaBalai ?? _namaBalai,
                            items: [
                              "Balai Besar Wilayah Sungai Ciliwung Cisadane",
                              "Balai Besar Wilayah Sungai Citarum",
                              "Balai Besar Wilayah Sungai Brantas"
                            ],
                            onChange: (value) {
                              setState(() {
                                _namaBalai = value;
                              });
                            },
                            hint: "Nama Balai",
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomDropdownField(
                            label: "Nama WS",
                            value: widget.sumur?.namaWs ?? _namaWS,
                            items: [
                              "WS Ciliwung Cisadane",
                              "WS Citarum",
                              "WS Brantas"
                            ],
                            onChange: (value) {
                              setState(() {
                                _namaWS = value;
                              });
                            },
                            hint: "Nama WS",
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomDropdownField(
                            label: "Nama DAS",
                            value: widget.sumur?.namaDas ?? _namaDAS,
                            items: [
                              "DAS Ciliwung",
                              "DAS Cisadane",
                              "DAS Citarum",
                              "DAS Brantas"
                            ],
                            onChange: (value) {
                              setState(() {
                                _namaDAS = value;
                              });
                            },
                            hint: "Nama DAS",
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomDropdownField(
                            label: "Kota",
                            value: widget.sumur?.kota ?? _kota,
                            items: [
                              "Jakarta",
                              "Bandung",
                              "Surabaya",
                              "Semarang",
                              "Yogyakarta"
                            ],
                            onChange: (value) {
                              setState(() {
                                _kota = value;
                              });
                            },
                            hint: "Kota",
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomDropdownField(
                            label: "Provinsi",
                            value: widget.sumur?.provinsi ?? _provinsi,
                            items: [
                              "DKI Jakarta",
                              "Jawa Barat",
                              "Jawa Tengah",
                              "Jawa Timur",
                              "DI Yogyakarta"
                            ],
                            onChange: (value) {
                              setState(() {
                                _provinsi = value;
                              });
                            },
                            hint: "Provinsi",
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomDropdownField(
                            label: "Kecamatan",
                            value: widget.sumur?.kecamatan ?? _kecamatan,
                            items: [
                              "Kampung Melayu",
                              "Jatinegara",
                              "Bandung Barat",
                              "Gubeng",
                              "Tegal Sari"
                            ],
                            onChange: (value) {
                              setState(() {
                                _kecamatan = value;
                              });
                            },
                            hint: "Kecamatan",
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomDropdownField(
                            label: "Kelurahan",
                            value: widget.sumur?.kelurahan ?? _kelurahan,
                            items: [
                              "Bidara Cina",
                              "Kampung Melayu",
                              "Cibiru",
                              "Airlangga",
                              "Kotabaru"
                            ],
                            onChange: (value) {
                              setState(() {
                                _kelurahan = value;
                              });
                            },
                            hint: "Kelurahan",
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: WidgetStatePropertyAll(
                                  Size(double.infinity, 46.h)),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              backgroundColor:
                                  WidgetStatePropertyAll(AppColor.primary),
                            ),
                            onPressed: _submitData,
                            child: Text(
                              widget.sumur != null
                                  ? "Ubah Data"
                                  : "Simpan Data",
                              style: AppTheme.button,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitData() {
    _updateLatLong();

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
      nama: _nameController.text, // Anda mungkin ingin mengubah ini sesuai kebutuhan
      koordinat: koordinat,
      operasi: _operasi ?? '',
      manfaatJiwa: _manfaatJiwaController.text,
      manfaatLuasDaerah: _manfaatLuasDaerahController.text,
      kondisiSumur: _kondisiSumurController.text,
      fungsiSumur: _fungsiSumurController.text,
      debit: _debitController.text.isEmpty
          ? 0
          : double.parse(_debitController.text),
      namaDas: _namaDAS ?? '',
      kota: _kota ?? '',
      provinsi: _provinsi ?? '',
      kecamatan: _kecamatan ?? '',
      kelurahan: _kelurahan ?? '',
      kodeIntegrasi: _kodeIntegrasiController.text,
      namaBalai: _namaBalai ?? '',
      namaWs: _namaWS ?? '',
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
    _manfaatLuasDaerahController.dispose();
    _debitController.dispose();
    _fungsiSumurController.dispose();
    _kondisiSumurController.dispose();
    _kodeIntegrasiController.dispose();
    super.dispose();
  }
}
