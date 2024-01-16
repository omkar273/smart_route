import 'package:smart_route/core/utils/network%20utils/network_utility.dart';

void placeAutocomplete(String query) async {
  Uri uri = Uri.https(
    'maps.googleapis.com',
    'maps/api/place/autocomplete/json', //encoder path
    {
      'input': query,
      'key': 'AIzaSyA8F-qYoy5395YtJqTRvIl3MY7J7pamWcY',
    },
  );
  String? response = await NetworkUtility.fetchUrl(uri);
  // ignore: avoid_print
  print(response);
}
