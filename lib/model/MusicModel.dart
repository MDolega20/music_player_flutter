import 'package:flute_music_player/flute_music_player.dart';
import 'package:scoped_model/scoped_model.dart';

class MusicModel extends Model{
  Song _song;
  List<Song> recent, favorite, all;

  Song get song => _song;

  Future findSounds() async {
    var _songs = await MusicFinder.allSongs();
    all = List.from(_songs);
  }
}