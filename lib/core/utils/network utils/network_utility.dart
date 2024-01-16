import 'package:dio/dio.dart';
import 'package:smart_route/core/utils/show_snackbar.dart';

class NetworkUtility {
  static Future<String?> fetchUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final resposnse =
          await Dio().getUri(uri, options: Options(headers: headers));
      if (resposnse.statusCode == 200) {
        return resposnse.data;
      }
    } catch (e) {
      showTextSnackBar(e.toString());
    }
    return null;
  }
}
