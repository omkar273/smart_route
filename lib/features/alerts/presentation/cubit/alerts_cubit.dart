import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'alerts_state.dart';

class AlertsCubit extends Cubit<AlertsState> {
  AlertsCubit() : super(AlertsInitial());
}
