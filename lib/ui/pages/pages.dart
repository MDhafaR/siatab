import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:siatab/cubit/mata_air_cubit.dart';
import 'package:siatab/cubit/sumur_cubit.dart';
import 'package:siatab/models/koordinat.dart';
import 'package:siatab/models/mata_air.dart';
import 'package:siatab/models/sumur.dart';
import 'package:siatab/themes/colors.dart';
import 'package:siatab/themes/theme.dart';
import 'package:siatab/ui/widgets/widgets.dart';
import 'package:siatab/utility.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'home_page.dart';
part 'home_page_full.dart';
part 'splash_screen.dart';
part 'login_page.dart';
part 'main_page.dart';
part 'mata_air_page.dart';
part 'sumur_page.dart';
part 'mata_air_request.dart';
part 'sumur_request.dart';
part 'detail_sumur.dart';