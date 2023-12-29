// // ignore_for_file: public_member_api_docs, sort_constructors_first
// // ignore_for_file: file_names

// import 'dart:io';
// import 'package:smart_route/core/utils/show_snackbar.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:share_plus/share_plus.dart';

// void shareScreenShot({required ScreenshotController controller}) async {
//   try {
//     final image = await controller.capture();
//     if (image != null) {
//       final directory = await getApplicationDocumentsDirectory();
//       final imagePath = await File('${directory.path}/image.png').create();
//       await imagePath.writeAsBytes(image);

//       await Share.shareXFiles(
//         [XFile(imagePath.path)],
//         text: "Image from music player",
//         subject: "Image from music player",
//       );
//       imagePath.delete();
//     }
//   } catch (e) {
//     showTextSnackBar(e.toString());
//   }
// }
