import 'package:get_it/get_it.dart';
import 'package:on_audio_query/on_audio_query.dart';

final locator = GetIt.instance;

Future<void> serviceLocatorInit() async {
  locator.registerLazySingleton<OnAudioQuery>(() => OnAudioQuery());
}
