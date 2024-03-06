import 'dart:async';

import 'package:permission_handler/permission_handler.dart';
import 'package:smart_route/core/utils/snackbar.dart';

FutureOr<bool> requestPermission(Permission permission) async {
  final PermissionStatus status = await permission.status;
  print('permission status for $permission $status');
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
