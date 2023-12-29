import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_route/main.dart';

void showPermissionSnackBar() {
  final SnackBar permissionSnackBar = SnackBar(
    content: const Text(
        "Some functionality may not work without necessary permissions"),
    action: SnackBarAction(label: "Grant", onPressed: () => openAppSettings()),
  );

  scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  scaffoldMessengerKey.currentState?.showSnackBar(permissionSnackBar);
}

void showTextSnackBar(String text) {
  final SnackBar permissionSnackBar = SnackBar(
    content: Text(text),
  );

  scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  scaffoldMessengerKey.currentState?.showSnackBar(permissionSnackBar);
}
