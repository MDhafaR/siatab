import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';

class Utility {
  static final instance = Utility._();

  factory Utility() => instance;

  Utility._();

  final localAuth = LocalAuthentication();

  Future<bool> checkLocationPermission() async {
    if (await Permission.location.serviceStatus.isDisabled) {
      Get.rawSnackbar(
          message:
              'Location services are disabled. Please enable the services');
      return false;
    }
    var status = await Permission.location.status;

    if (status.isDenied) {
      status = await Permission.location.request();
      if (status.isDenied) {
        Get.rawSnackbar(message: 'Location permissions are denied');
        return false;
      }
    }
    if (status.isPermanentlyDenied) {
      Get.rawSnackbar(
          message:
              'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }
}