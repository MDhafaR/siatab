part of 'pages.dart';

class HomePageFull extends StatefulWidget {
  HomePageFull(
      {required this.advancedDrawerController,
      required this.currentTab,
      required this.onTabChange,
      required this.mapController,
      super.key});

  final AdvancedDrawerController advancedDrawerController;
  final String currentTab;
  final Function(String) onTabChange;
  MapController mapController;

  @override
  State<HomePageFull> createState() => _HomePageFullState();
}

class _HomePageFullState extends State<HomePageFull> {
  bool isDrawerOpen = false;
  double _panelPosition = 0.0;

  @override
  void initState() {
    super.initState();
    widget.advancedDrawerController.addListener(_handleDrawerChange);
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
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
                      isFull: true,
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
                  child: IntrinsicWidth(
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColor.white),
                              borderRadius: BorderRadius.circular(12),
                              color: AppColor.white.withOpacity(0.7)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          !isDrawerOpen
                              ? InkWell(
                                  onTap: () {
                                    widget.advancedDrawerController
                                        .showDrawer();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/menu.svg",
                                      width: 26,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: 24.h,
                                ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 24),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Row(
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
                          ),
                          Container(
                            padding: EdgeInsets.all(7.2),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: InkWell(
                                onTap: () {
                                  widget.onTabChange('peta sebaran');
                                },
                                child: SvgPicture.asset("assets/minimize.svg")),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
