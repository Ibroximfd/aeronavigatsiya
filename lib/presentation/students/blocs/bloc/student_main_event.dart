abstract class StudentMainEvent {
  const StudentMainEvent();
}

class ChangePageEvent extends StudentMainEvent {
  final int index;

  const ChangePageEvent(this.index);
}