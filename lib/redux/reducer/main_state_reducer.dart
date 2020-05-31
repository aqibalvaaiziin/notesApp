import 'package:notesapp/redux/action/main_state_action.dart';
import 'package:notesapp/redux/model/main_state_model.dart';
import 'package:redux/redux.dart';

final mainReducer = combineReducers<MainState>([
  TypedReducer<MainState, SetMainState>(_setMainState),
]);

MainState _setMainState(MainState state, SetMainState payload) {
  return state.copyWith(
    albums: payload.albums,
    albumById: payload.albumById,
    notes: payload.notes,
  );
}
