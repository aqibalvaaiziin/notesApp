import 'package:meta/meta.dart';
import 'package:notesapp/redux/model/main_state_model.dart';

@immutable
class AppState {
  final MainState mainState;
  AppState({this.mainState});

  factory AppState.inital() {
    return AppState(mainState: MainState.initial());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          mainState == other.mainState;

  @override
  int get hashCode => mainState.hashCode;
}
