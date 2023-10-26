import 'package:flutter_bloc/flutter_bloc.dart';

import 'pick_date_state.dart';

export 'pick_date_state.dart';

class PickDateCubit extends Cubit<PickDateState> {
  PickDateCubit() : super(PickDateState(date: DateTime.now()));

  void changeDate(DateTime date) => emit(PickDateState(date: date));
}
