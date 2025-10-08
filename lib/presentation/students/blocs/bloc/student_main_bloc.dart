import 'package:flutter_bloc/flutter_bloc.dart';

import 'student_main_event.dart';
import 'student_main_state.dart';

class StudentMainBloc extends Bloc<StudentMainEvent, StudentMainState> {
  StudentMainBloc() : super(const StudentMainState(currentIndex: 0)) {
    on<ChangePageEvent>((event, emit) {
      emit(StudentMainState(currentIndex: event.index));
    });
  }
}
