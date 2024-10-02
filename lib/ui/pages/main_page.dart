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
  List<LatLng> _routePoints = [];
  Position? _currentPosition;
  bool _isLoading = false;

  // untuk pengecekan apakah routenya sama dengan sebelumnya atau tidak
  List<LatLng> _currentRoutePoints = [];
  double? _currentEndLatitude;
  double? _currentEndLongitude;

  void _setLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  void setTab(String newTab) {
    setState(() {
      _currentTab = newTab;
    });
  }

  @override
  void initState() {
    _mapController = MapController();
    _advancedDrawerController.addListener(_handleDrawerChange);
    _getCurrentPosition();
    super.initState();
  }

  Future<void> _getCurrentPosition() async {
    _setLoading(true);
    final isLocationGranted = await Utility.instance.checkLocationPermission();
    if (!isLocationGranted) {
      _setLoading(false);
      return;
    }
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
      });
      await _getRoute(_currentPosition!, null, null);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _getRoute(
      Position start, double? endLatitude, double? endLongitude) async {
    if (endLatitude == _currentEndLatitude &&
        endLongitude == _currentEndLongitude &&
        _currentRoutePoints.isNotEmpty) {
      setState(() {
        _routePoints = _currentRoutePoints;
      });
      LatLngBounds bounds = LatLngBounds.fromPoints(
          _createMarkers().map((marker) => marker.point).toList());
      _mapController.fitCamera(CameraFit.bounds(
          bounds: bounds,));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final OpenRouteService client = OpenRouteService(
        apiKey: '5b3ce3597851110001cf6248387193944b4147e28f526f7e9b949e63',
      );
      final List<ORSCoordinate> routeCoordinates =
          await client.directionsRouteCoordsGet(
        startCoordinate:
            ORSCoordinate(latitude: start.latitude, longitude: start.longitude),
        endCoordinate: ORSCoordinate(
            latitude: endLatitude ?? start.latitude,
            longitude: endLongitude ?? start.longitude),
      );
      final List<LatLng> routePoints = routeCoordinates
          .map(
              (coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
          .toList();

      setState(() {
        _routePoints = routePoints;
        _currentRoutePoints = routePoints;
        _currentEndLatitude = endLatitude;
        _currentEndLongitude = endLongitude;
      });
    } catch (e) {
      debugPrint('Error getting route: ${e.toString()}');
    } finally {
      setState(() {
        LatLngBounds bounds = LatLngBounds.fromPoints(
          _createMarkers().map((marker) => marker.point).toList());
      _mapController.fitCamera(CameraFit.bounds(
          bounds: bounds,));
        _isLoading = false;
      });
    }
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
          routePoints: _routePoints,
          currentPosition: _currentPosition,
          currentLoading: _isLoading,
          setCurrentLoading: _setLoading,
        );
      case 'peta sebaran full':
        return HomePageFull(
          advancedDrawerController: _advancedDrawerController,
          onTabChange: setTab,
          mapController: _mapController,
          markers: _createMarkers(),
          routePoints: _routePoints,
          currentPosition: _currentPosition,
          currentLoading: _isLoading,
          setCurrentLoading: _setLoading,
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
                    onPressed: isDialogOpen
                        ? null
                        : () {
                            showCustomDialog(context);
                            setState(() {
                              _getRoute(_currentPosition!, latLng.latitude,
                                  latLng.longitude);
                            });
                          },
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
