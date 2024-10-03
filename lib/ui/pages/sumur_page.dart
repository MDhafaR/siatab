part of 'pages.dart';

class SumurPage extends StatefulWidget {
  const SumurPage({
    required this.advancedDrawerController,
    required this.onTabChange,
    super.key,
  });

  final AdvancedDrawerController advancedDrawerController;
  final Function(String) onTabChange;

  @override
  State<SumurPage> createState() => _SumurPageState();
}

class _SumurPageState extends State<SumurPage> {
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    widget.advancedDrawerController.addListener(_handleDrawerChange);
    context.read<SumurCubit>().loadSumur();
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
        leading: SvgPicture.asset(
          "assets/menu.svg",
          width: isDrawerOpen ? 0 : 26,
        ),
        tapLeading: () {
          setState(() {
            isDrawerOpen = true;
          });
          widget.advancedDrawerController.showDrawer();
        },
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Text(
                      "Input Data Sumur",
                      style: AppTheme.caption2.copyWith(color: AppColor.dark),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => SumurRequest());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColor.primary,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(
                        children: [
                          Icon(Icons.add, color: AppColor.white, size: 18),
                          SizedBox(width: 8.w),
                          Text(
                            "Data Sumur",
                            style:
                                AppTheme.medium.copyWith(color: AppColor.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              TextField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  filled: true,
                  fillColor: AppColor.white,
                  hintText: "Cari Data",
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColor.light,
                    size: 20,
                  ),
                  hintStyle: AppTheme.title4.copyWith(color: AppColor.light),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: BorderSide(color: AppColor.superLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: BorderSide(color: AppColor.superLight),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: BlocBuilder<SumurCubit, SumurState>(
                  builder: (context, state) {
                    if (state is SumurLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is SumurLoaded) {
                      if (state.sumurList.isEmpty) {
                        return EmptyWidget();
                      }
                      return ListView.builder(
                        itemCount: state.sumurList.length,
                        itemBuilder: (context, index) {
                          final sumur = state.sumurList[index];
                          return SumurCard(
                            sumur: sumur,
                          );
                        },
                      );
                    } else if (state is SumurError) {
                      print("error ${state.message}");
                      return EmptyWidget();
                    }
                    return EmptyWidget();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
