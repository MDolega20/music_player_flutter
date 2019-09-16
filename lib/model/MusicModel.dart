import 'package:flute_music_player/flute_music_player.dart';
import 'package:scoped_model/scoped_model.dart';

// https://github.com/iampawan/Flutter-Music-Player/blob/master/lib/data/song_data.dart


class MusicModel extends Model{
  Song _song;
  List<Song> recent, favorite, songs;
  bool loading = false;
  String error;

  Song get song => _song;

  findSounds() async {
    try {
      loading = true;
      var _songs = await MusicFinder.allSongs();
      songs = List.from(_songs);
    } catch (e) {
      error = e.messege;
      print("Failed to get songs: '${e.message}'.");
    } finally{
      loading = false;
    }
  }
}