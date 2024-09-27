part of 'pages.dart';

class HomePage extends StatefulWidget {
  HomePage({
    required this.advancedDrawerController,
    required this.onTabChange,
    required this.mapController,
    super.key,
  });

  final AdvancedDrawerController advancedDrawerController;
  final Function(String) onTabChange;
  MapController mapController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDrawerOpen = false;
  double _panelPosition = 0.0;
  Position? _currentPosition;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.advancedDrawerController.addListener(_handleDrawerChange);
    _getCurrentPosition();
  }

  @override
  void dispose() {
    widget.advancedDrawerController.removeListener(_handleDrawerChange);
    super.dispose();
  }

  void _handleDrawerChange() {
    setState(() {
      isDrawerOpen = widget.advancedDrawerController.value ==
          AdvancedDrawerValue.visible();
    });
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
        _currentPosition = position;
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    widget.advancedDrawerController.showDrawer();
                  },
                  child: SvgPicture.asset(
                    "assets/menu.svg",
                    width: isDrawerOpen ? 0 : 26,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/map.svg",
                      width: 18,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Peta Sebaran",
                      style: AppTheme.title,
                    )
                  ],
                ),
                SvgPicture.asset(
                  "assets/notification.svg",
                  width: 26,
                ),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    FlutterMap(
                      mapController: widget.mapController,
                      options: const MapOptions(
                        initialCenter: LatLng(-6.9481298, 107.6595105),
                        initialZoom: 15,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.technoinfinity.siatab',
                        ),
                        MarkerLayer(markers: [
                          Marker(
                            rotate: true,
                            height: 50,
                            width: 50,
                            point: const LatLng(-6.9481298, 107.6595104),
                            child: ValueListenableBuilder(
                              valueListenable: dialogOpenNotifier,
                              builder: (context, isDialogOpen, _) {
                                return IconButton(
                                  onPressed: isDialogOpen
                                      ? null
                                      : () => showCustomDialog(context),
                                  icon: SvgPicture.asset(
                                    'assets/intake_sungai_non_aktif.svg',
                                    width: 32.w,
                                  ),
                                );
                              },
                            ),
                          ),
                          if (_currentPosition != null) ...[
                            Marker(
                              rotate: true,
                              height: 40,
                              width: 40,
                              point: LatLng(_currentPosition!.latitude,
                                  _currentPosition!.longitude),
                              child: SvgPicture.asset(
                                'assets/my_location.svg',
                                width: 32.w,
                              ),
                            ),
                          ],
                        ])
                      ],
                    ),
                    SlidingUpPanel(
                      onPanelSlide: (position) {
                        setState(() {
                          _panelPosition = position;
                        });
                      },
                      panelBuilder: (controller) {
                        return PanelWidget(
                          isFull: false,
                          controller: controller,
                        );
                      },
                      margin: EdgeInsets.symmetric(horizontal: 9),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      minHeight: size.height * 0.07,
                      maxHeight: size.height * 0.45,
                    ),
                    Positioned(
                        left: 9,
                        bottom: size.height * (0.45 - 0.07) * _panelPosition +
                            size.height * 0.07 +
                            10,
                        child: ValueListenableBuilder(
                          valueListenable: dialogOpenNotifier,
                          builder: (context, isDialogOpen, _) {
                            if (isDialogOpen) return SizedBox();
                            return IntrinsicWidth(
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: AppColor.white),
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColor.white.withOpacity(0.4)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Legenda",
                                          style: AppTheme.caption4,
                                        ),
                                        SizedBox(
                                          height: 7.h,
                                        ),
                                        DashLine(
                                          ketebalan: 1,
                                          warna: AppColor.superLight,
                                          jarakAntarGaris: 3,
                                          panjangGaris: 7,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        ListLegenda(
                                          svgTitle: 'intake_sungai_aktif',
                                          title: 'Intake Sungai Aktif',
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        ListLegenda(
                                          svgTitle: 'intake_sungai_non_aktif',
                                          title: 'Intake Sungai Non Aktif',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: EdgeInsets.only(top: 18, right: 12),
                        padding: EdgeInsets.all(7.2),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: InkWell(
                            onTap: () {
                              widget.onTabChange('peta sebaran full');
                            },
                            child: SvgPicture.asset("assets/maximize.svg")),
                      ),
                    ),
                    if (_isLoading)
                      Dialog(
                        backgroundColor: Colors.transparent,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColor.primary,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
