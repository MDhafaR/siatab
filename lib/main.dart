import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:siatab/cubit/mata_air_cubit.dart';
import 'package:siatab/cubit/sumur_cubit.dart';
import 'package:siatab/services/local_database.dart';
import 'package:siatab/ui/pages/pages.dart';
import 'package:siatab/themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SumurCubit(LocalDatabase())),
        BlocProvider(create: (context) => MataAirCubit(LocalDatabase())),
      ],
      child: ScreenUtilInit(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          theme: AppTheme.light(),
        ),
      ),
    );
  }
}
