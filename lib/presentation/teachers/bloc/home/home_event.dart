abstract class HomeEvent {}

class SelectPageEvent extends HomeEvent {
  final int index;
  SelectPageEvent(this.index);
}

class ShowAboutDialogEvent extends HomeEvent {}

class ShowContactSheetEvent extends HomeEvent {}

class ShareAppEvent extends HomeEvent {}

class OpenAdminPanelEvent extends HomeEvent {}
