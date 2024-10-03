part of 'widgets.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200.w,
            height: 150.h,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/empty.png"),
            )),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text("Tidak ada Data Tersedia", style: AppTheme.big,),
          SizedBox(
            height: 8.h,
          ),
          Text("Tidak ada data tersedia silahkan refresh\nmenu terlebih dahulu", style: AppTheme.caption2, textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}