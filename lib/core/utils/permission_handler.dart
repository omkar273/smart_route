import 'dart:async';

import 'package:permission_handler/permission_handler.dart';
import 'package:smart_route/core/utils/show_snackbar.dart';

FutureOr<bool> requestPermission(Permission permission) async {
  final PermissionStatus status = await permission.status;

  if (status.isGranted) {
    return true;
  }
  if (status.isPermanentlyDenied) {
    openAppSettings();
  }

  if (status.isDenied ||
      status.isLimited ||
      status.isProvisional ||
      status.isRestricted) {
    showPermissionSnackBar();
    return await permission.request().isGranted;
  }

  return false;
}
