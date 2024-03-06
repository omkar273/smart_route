import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'music_state.dart';

class MusicCubit extends Cubit<MusicState> {
  MusicCubit() : super(MusicInitial());
}
