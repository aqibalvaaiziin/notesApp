import 'package:meta/meta.dart';

@immutable
class MainState {
  final List albums;
  final List albumById;
  final List notes;

  MainState({
    @required this.albums,
    @required this.albumById,
    @required this.notes,
  });

  factory MainState.initial() {
    return MainState(
      albums: [],
      albumById: [],
      notes: [],
    );
  }

  MainState copyWith({List albums, List notes, List albumById}) {
    return MainState(
      albums: albums ?? this.albums,
      albumById: albumById ?? this.albumById,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainState &&
          runtimeType == other.runtimeType &&
          albums == other.albums &&
          albumById == other.albumById &&
          notes == other.notes;

  @override
  int get hashCode => albums.hashCode ^ notes.hashCode ^ albumById.hashCode;
}
