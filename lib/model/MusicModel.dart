//import 'package:flute_music_player/flute_music_player.dart';
import 'package:scoped_model/scoped_model.dart';

// https://github.com/iampawan/Flutter-Music-Player/blob/master/lib/data/song_data.dart
// https://github.com/florent37/Flutter-AssetsAudioPlayer


class MusicModel extends Model{
  Track _song;
  List<Track> recent, favorite, songs;
  bool loading = false;
  String error;



//  Song get song => _song;

  findSounds() async {
    loading = true;
    List<Track> _tracks = [
      Track("Nazwa utworu 1","Autor", "track01.mp3", "music"),
      Track("Nazwa utworu 2","Autor", "track02.mp3", "music"),
      Track("Nazwa utworu 3","Autor", "track03.mp3", "music"),
    ];

    songs = _tracks;
    loading = false;

//    try {
//      MusicFinder audioPlayer = new MusicFinder();
//
//      loading = true;
//      var _songs = await MusicFinder.allSongs();
//      songs = List.from(_songs);
//    } catch (e) {
//      error = e.messege;
//      print("Failed to get songs: '${e.message}'.");
//    } finally{
//      loading = false;
//    }
  }
}

class Track {
  String title;
  String author;
  String assetName;
  String assetFolder;

  Track(title, author, assetName, assetFolder);
}