part of 'pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _advancedDrawerController = AdvancedDrawerController();
  bool isDrawerOpen = false;
  String _currentTab = 'peta sebaran';
  late MapController _mapController;

  void setTab(String newTab) {
    setState(() {
      _currentTab = newTab;
    });
  }

  @override
  void initState() {
    _mapController = MapController();
    _advancedDrawerController.addListener(_handleDrawerChange);
    super.initState();
  }

  @override
  void dispose() {
    _advancedDrawerController.removeListener(_handleDrawerChange);
    super.dispose();
  }

  void _handleDrawerChange() {
    setState(() {
      isDrawerOpen =
          _advancedDrawerController.value == AdvancedDrawerValue.visible();
    });
  }

  void _closeDrawer() {
    _advancedDrawerController.hideDrawer();
    setState(() {
      isDrawerOpen = false;
    });
  }

  Widget _page() {
    switch (_currentTab) {
      case 'peta sebaran':
        return HomePage(
          advancedDrawerController: _advancedDrawerController,
          onTabChange: setTab,
          mapController: _mapController,
          markers: _createMarkers(),
        );
      case 'peta sebaran full':
        return HomePageFull(
          advancedDrawerController: _advancedDrawerController,
          onTabChange: setTab,
          mapController: _mapController,
          markers: _createMarkers(),
        );
      case 'mata air':
        return MataAirPage(
          advancedDrawerController: _advancedDrawerController,
          onTabChange: setTab,
        );
      case 'sumur':
        return SumurPage(
          advancedDrawerController: _advancedDrawerController,
          onTabChange: setTab,
        );
      default:
        return LoginPage();
    }
  }

  List<LatLng> dummyLocations = [
    LatLng(-6.9481298, 107.6595104), // Titik pusat
    LatLng(-6.9390298, 107.6686104), // Sekitar 1.5 km ke timur laut
    LatLng(-6.9572298, 107.6504104), // Sekitar 1.5 km ke barat daya
    LatLng(-6.9346298, 107.6595104), // Sekitar 1.5 km ke utara
    LatLng(-6.9616298, 107.6595104), // Sekitar 1.5 km ke selatan
  ];

  List<Marker> _createMarkers() {
    return dummyLocations
        .map((latLng) => Marker(
              rotate: true,
              height: 50,
              width: 50,
              point: latLng,
              child: ValueListenableBuilder(
                valueListenable: dialogOpenNotifier,
                builder: (context, isDialogOpen, _) {
                  return IconButton(
                    onPressed:
                        isDialogOpen ? null : () => showCustomDialog(context),
                    icon: SvgPicture.asset(
                      'assets/intake_sungai_non_aktif.svg',
                      width: 32.w,
                    ),
                  );
                },
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
        openRatio: 0.7,
        childDecoration: BoxDecoration(borderRadius: BorderRadius.circular(44)),
        animationDuration: Duration(milliseconds: 500),
        backdrop: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png"), fit: BoxFit.cover),
          ),
        ),
        controller: _advancedDrawerController,
        drawer: SideBar(
          onTabChange: setTab,
          currentTab: _currentTab,
          advancedDrawerController: _advancedDrawerController,
          closeDrawer: _closeDrawer,
        ),
        child: _page());
  }
}
