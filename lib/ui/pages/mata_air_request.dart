part of 'pages.dart';

class MataAirRequest extends StatefulWidget {
  MataAirRequest({
    Key? key,
    this.mataAir,
  }) : super(key: key);

  final MataAir? mataAir;

  @override
  State<MataAirRequest> createState() => _MataAirRequestState();
}

class _MataAirRequestState extends State<MataAirRequest> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _kodeIntegrasiController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;
  late TextEditingController _koordinatController;
  late TextEditingController _manfaatJiwaController;
  late TextEditingController _manfaatLuasDaerahController;

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
    _nameController = TextEditingController(text: widget.mataAir?.nama);
    _kodeIntegrasiController =
        TextEditingController(text: widget.mataAir?.kodeIntegrasi);
    _latitudeController = TextEditingController(
      text: widget.mataAir != null
          ? widget.mataAir!.koordinat.latitude.toString()
          : '',
    );
    _longitudeController = TextEditingController(
      text: widget.mataAir != null
          ? widget.mataAir!.koordinat.longitude.toString()
          : '',
    );
    _koordinatController = TextEditingController(
      text: widget.mataAir != null
          ? _formatKoordinat(widget.mataAir!.koordinat.latitude,
              widget.mataAir!.koordinat.longitude)
          : '',
    );
    _manfaatJiwaController =
        TextEditingController(text: widget.mataAir?.manfaatJiwa);
    _manfaatLuasDaerahController =
        TextEditingController(text: widget.mataAir?.manfaatLuasDaerah);
    _operasi = widget.mataAir?.operasi;

    if (widget.mataAir == null) {
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
            Text("Data mataAir", style: AppTheme.title),
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
                    widget.mataAir != null
                        ? "Ubah Data mataAir"
                        : "Input Data mataAir",
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
                            label: "Nama/No mataAir",
                            hintText: "Nama / No mataAir",
                          ),
                          SizedBox(height: 16.h),
                          CustomFormField(
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9 ,\-.]')),
                              CoordinateFormatter()
                            ],
                            controller: _koordinatController,
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
                          CustomDropdownField(
                            label: "Status Operasi",
                            value: widget.mataAir?.operasi ?? _operasi,
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
                            value: widget.mataAir?.namaBalai ?? _namaBalai,
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
                            value: widget.mataAir?.namaWs ?? _namaWS,
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
                            value: widget.mataAir?.namaDas ?? _namaDAS,
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
                            value: widget.mataAir?.kota ?? _kota,
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
                            value: widget.mataAir?.provinsi ?? _provinsi,
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
                            value: widget.mataAir?.kecamatan ?? _kecamatan,
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
                            value: widget.mataAir?.kelurahan ?? _kelurahan,
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
                              widget.mataAir != null
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

    final mataAir = MataAir(
      nama: _nameController
          .text, // Anda mungkin ingin mengubah ini sesuai kebutuhan
      koordinat: koordinat,
      operasi: _operasi ?? '',
      manfaatJiwa: _manfaatJiwaController.text,
      manfaatLuasDaerah: _manfaatLuasDaerahController.text,
      namaDas: _namaDAS ?? '',
      kota: _kota ?? '',
      provinsi: _provinsi ?? '',
      kecamatan: _kecamatan ?? '',
      kelurahan: _kelurahan ?? '',
      kodeIntegrasi: _kodeIntegrasiController.text,
      namaBalai: _namaBalai ?? '',
      namaWs: _namaWS ?? '',
    );

    if (widget.mataAir == null) {
      context.read<MataAirCubit>().addMataAir(mataAir);
    } else {
      mataAir.id = widget.mataAir!.id;
      context.read<MataAirCubit>().updateMataAir(mataAir);
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
    _kodeIntegrasiController.dispose();
    super.dispose();
  }
}
