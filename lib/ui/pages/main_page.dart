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
        );
      case 'peta sebaran full':
        return HomePageFull(
          advancedDrawerController: _advancedDrawerController,
          onTabChange: setTab,
          mapController: _mapController,
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
