import 'package:smart_route/core/utils/show_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

void makeCall(String phone) async {
  final Uri url = Uri.parse('tel:+91 $phone');
  if (await canLaunchUrl(url)) {
    launchUrl(url);
  } else {
    showTextSnackBar('cant place a call');
  }
}
