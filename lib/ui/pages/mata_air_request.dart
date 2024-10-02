part of 'pages.dart';

class MataAirRequest extends StatefulWidget {
  MataAirRequest({
    super.key,
    this.mataAir,
  });

  final MataAir? mataAir;

  @override
  State<MataAirRequest> createState() => _MataAirRequestState();
}

class _MataAirRequestState extends State<MataAirRequest> {
  String? _dropValue;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;
  late TextEditingController _koordinatController;
  late TextEditingController _manfaatJiwaController;
  late TextEditingController _manfaatLuasController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
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
    _dropValue = widget.mataAir?.operasi;
    _manfaatJiwaController =
        TextEditingController(text: widget.mataAir?.manfaatJiwa);
    _manfaatLuasController =
        TextEditingController(text: widget.mataAir?.manfaatIrigasi);

    if (widget.mataAir == null) {
      _getCurrentPosition();
    }
  }

  @override
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    _koordinatController.removeListener(_updateLatLong);
    _manfaatJiwaController.dispose();
    _manfaatLuasController.dispose();
    super.dispose();
  }

  String _formatKoordinat(double? lat, double? long) {
    if (lat != null && long != null) {
      return "${lat.toStringAsFixed(6)} , ${long.toStringAsFixed(6)}";
    }
    return "";
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

    final mataAir = MataAir(
      name: "belum", // Anda mungkin ingin mengubah ini sesuai kebutuhan
      koordinat: koordinat,
      operasi: _dropValue ?? '',
      manfaatJiwa: _manfaatJiwaController.text,
      manfaatIrigasi: _manfaatLuasController.text,
    );

    if (widget.mataAir == null) {
      context.read<MataAirCubit>().addMataAir(mataAir);
    } else {
      mataAir.id = widget.mataAir!.id;
      context.read<MataAirCubit>().updateMataAir(mataAir);
    }

    Navigator.pop(context);
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
            Text("Data Mata Air", style: AppTheme.title),
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
                widget.mataAir != null
                    ? "Ubah Data Mata Air"
                    : "Input Data Mata Air",
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
              CustomDropdownField(
                label: "Status Operasi",
                value: _dropValue,
                items: ["Operasi", "Tidak Operasi"],
                onChange: (value) {
                  setState(() {
                    _dropValue = value;
                  });
                },
                hint: "Status Operasi",
              ),
              SizedBox(height: 16.h),
              CustomFormField(
                controller: _manfaatJiwaController,
                label: "Manfaat Jiwa",
                hintText: "Manfaat Jiwa",
              ),
              SizedBox(height: 16.h),
              CustomFormField(
                controller: _manfaatLuasController,
                label: "Manfaat Luas Daerah Irigasi",
                hintText: "Manfaat Luas Daerah Irigasi",
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize:
                      WidgetStatePropertyAll(Size(double.infinity, 46.h)),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
                  backgroundColor: WidgetStatePropertyAll(AppColor.primary),
                ),
                onPressed: _submitData,
                child: Text(
                  widget.mataAir != null ? "Ubah Data" : "Simpan Data",
                  style: AppTheme.button,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
